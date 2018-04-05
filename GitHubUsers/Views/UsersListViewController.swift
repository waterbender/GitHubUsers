//
//  ViewController.swift
//  GitHubUsers
//
//  Created by Yevgenii Pasko on 4/5/18.
//  Copyright © 2018 Yevgenii Pasko. All rights reserved.
//

import UIKit

class UsersListViewController: UIViewController {

    let usersListViewModel = UsersListViewModel()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let nib = UINib(nibName: "UserListTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: Constants.UsersListCellIndetifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UsersListCellIndetifier) as? UserListTableViewCell else {
            return UITableViewCell()
        }
       
        return self.configurateCell(cell: cell, indexPath: indexPath)
    }
    
    private func configurateCell(cell: UserListTableViewCell, indexPath: IndexPath) -> UserListTableViewCell {

        let user = usersListViewModel.usersArray[indexPath.row]
        cell.setUserPropertiesData(user: user)
        
        return cell
    }

    
    

}

