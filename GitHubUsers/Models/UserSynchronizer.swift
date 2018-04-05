//
//  UserSynchronizer.swift
//  GitHubUsers
//
//  Created by Yevgenii Pasko on 4/6/18.
//  Copyright © 2018 Yevgenii Pasko. All rights reserved.
//

import UIKit

class UserSynchronizer {

    func getUsers(since: Int, perPage: Int, complitionBlock:@escaping ([User])->()) {
        
        let urlString = "\(Constants.UserUrlRequestForTable)?\(Constants.SinceMethod)=\(since)&\(Constants.PerPage)=\(perPage)&\(Constants.ClientIDField)=\(Constants.ClientID)&\(Constants.ClientSecretField)=\(Constants.ClientSecret)"
        let webClient = WebAndFilesClient()
        webClient.getRequestUsersList(urlString: urlString) { (data) in
            do {
                let usersArray = try JSONDecoder().decode([User].self, from: data)
                complitionBlock(usersArray)
            } catch {
                print(error)
            }
        }
    }
    
    func getFollowers(since: Int, perPage: Int, url: URL, complitionBlock:@escaping ([User])->()) {
        
        let urlString = "\(url.absoluteString)?\(Constants.SinceMethod)=\(since)&\(Constants.PerPage)=\(perPage)&\(Constants.ClientIDField)=\(Constants.ClientID)&\(Constants.ClientSecretField)=\(Constants.ClientSecret)"
        let webClient = WebAndFilesClient()
        webClient.getRequestUsersList(urlString: urlString) { (data) in
            do {
                let usersArray = try JSONDecoder().decode([User].self, from: data)
                complitionBlock(usersArray)
            } catch {
                print(error)
            }
        }
    }
}
