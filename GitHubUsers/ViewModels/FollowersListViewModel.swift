//
//  FollowersListViewModel.swift
//  GitHubUsers
//
//  Created by Yevgenii Pasko on 4/6/18.
//  Copyright © 2018 Yevgenii Pasko. All rights reserved.
//

import UIKit

class FollowersListViewModel: UsersList {
    
    // default array for Users table
    private (set) var usersArray = Array<User>()
    private let usersSync = UserSynchronizer()
    private var userFollowersUrl: URL
    private var insetPosition = 500
    
    var reloadTableBlock: (()->())?
    var userName: String
    
    init(url: URL, userName: (String)) {
        self.userName = userName
        self.userFollowersUrl = url
        loadData(perPage: 30)
    }
    
    func loadData(perPage: Int) {
        if perPage > 0 {
            usersSync.getFollowers(since: self.insetPosition, perPage: perPage, url: self.userFollowersUrl) { [weak self] (users) in
                self?.usersArray.append(contentsOf: users)
                self?.insetPosition = (self?.insetPosition ?? 0)+(self?.usersArray.count ?? 0)
                guard let block = self?.reloadTableBlock else {
                    return
                }
                OperationQueue.main.addOperation {
                    block()
                }
            }
        }
    }
    
    func refreshData() {
        usersArray.removeAll()
        loadData(perPage: insetPosition)
    }
    
    func createFollowersListViewModel(indexPath: IndexPath) -> (FollowersListViewModel) {
        
        let user = usersArray[indexPath.row]
        let followersListViewModel = FollowersListViewModel(url: user.followersUrl, userName:user.login)
        return followersListViewModel
    }
}
