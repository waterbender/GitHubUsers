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
    
    var reloadTableBlock: (()->())?
    var userName: String
    
    init(url: URL, userName: (String)) {
        self.userName = userName
        self.userFollowersUrl = url
        loadData(since: 0, perPage: 30)
    }
    
    func loadData(since: Int, perPage: Int) {
        if since >= usersArray.count {
            usersSync.getFollowers(since: since, perPage: perPage, url: self.userFollowersUrl) { [weak self] (users) in
                self?.usersArray.append(contentsOf: users)
                guard let block = self?.reloadTableBlock else {
                    return
                }
                OperationQueue.main.addOperation {
                    block()
                }
            }
        }
    }
    
    func createFollowersListViewModel(indexPath: IndexPath) -> (FollowersListViewModel) {
        
        let user = usersArray[indexPath.row]
        let followersListViewModel = FollowersListViewModel(url: user.followersUrl, userName:user.login)
        return followersListViewModel
    }
}
