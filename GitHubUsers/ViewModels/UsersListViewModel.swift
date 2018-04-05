//
//  func setProductData(product:Product) {  self.productName.text = product.name  self.productQuantity.text = "\(product.swift
//  GitHubUsers
//
//  Created by Yevgenii Pasko on 4/5/18.
//  Copyright © 2018 Yevgenii Pasko. All rights reserved.
//

import UIKit

protocol UsersList {
    // empty protocol
    var usersArray: [User] {get}
    var reloadTableBlock: (()->())? {get set}
}

class UsersListViewModel: UsersList {

    // default array for Users table
    private (set) var usersArray = Array<User>()
    var reloadTableBlock: (()->())?
    private let usersSync = UserSynchronizer()
    
    init() {
        loadData(since: 0, perPage: 30)
    }
    
    func loadData(since: Int, perPage: Int) {
        if since >= usersArray.count {
            usersSync.getUsers(since: since, perPage: perPage) { [weak self] (users) in
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
