//
//  Constants.swift
//  SANDBX CARS
//
//  Created by Yevgenii Pasko on 3/26/18.
//  Copyright © 2018 Yevgenii Pasko. All rights reserved.
//

import UIKit

class Constants {
    
    // MARK: List of Constants
    static let UsersListCellIndetifier = "UsersListCellIndetifier"
    static let FollowersListCellIndetifier = "FollowersListCellIndetifier"
    
    static let UserUrlRequestForTable = "https://api.github.com/users"
    static let UserUrlRequestRepository = "https://api.github.com/repositories"

    // Parameters
    static let SinceMethod = "since"
    static let PerPage = "per_page"
    
    static let ClientIDField = "client_id"
    static let ClientSecretField = "client_secret"
    
    //per_page=100
    
    // Users List view controller name
    static let UsersListTitle = "Github Users"
    static let FollowersListTitle = "Followers"
    
    static let FollowersSegue = "OpenFollowersSegueIdenifier"
    static let FollowersItselfSegue = "OpenFollowersFromFolowersSegueIdenifier"
    
    // Creditant
    static let ClientID = "b577800897d8b1a6ec64"
    static let ClientSecret = "e2451f23fdd36081aa9cfda8a0cd57931aebede2"
}
