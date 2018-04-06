//
//  ViewController.swift
//  GitHubUsers
//
//  Created by Yevgenii Pasko on 4/5/18.
//  Copyright © 2018 Yevgenii Pasko. All rights reserved.
//

import UIKit

class UsersListViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    let usersListViewModel = UsersListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // settings for navbar
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = Constants.UsersListTitle
        self.navigationController?.navigationBar.backgroundColor = UIColor.cyan
        self.navigationController?.delegate = self;
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.lightGray
        
        // subscribing nib to controller
        let nib = UINib(nibName: "UserListTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: Constants.UsersListCellIndetifier)
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = UITableViewAutomaticDimension
        usersListViewModel.reloadTableBlock = {[weak self] in
            self?.tableView.reloadData()
        }
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension UsersListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersListViewModel.usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.UsersListCellIndetifier) as? UserListTableViewCell else {
            return UITableViewCell()
        }
        self.configurateCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    private func configurateCell(cell: UserListTableViewCell, indexPath: IndexPath) {
        
        let user = usersListViewModel.usersArray[indexPath.row]
        cell.setUserPropertiesData(user: user)
    }
}

extension UsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if usersListViewModel.usersArray.count-20 == indexPath.row {
            usersListViewModel.loadData(since: usersListViewModel.usersArray.count, perPage: 30)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: Constants.FollowersSegue, sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.FollowersSegue {
            let indexPath = sender as? IndexPath ?? IndexPath()
            let viewModel = usersListViewModel.createFollowersListViewModel(indexPath: indexPath)
            let finalController = segue.destination as! FollowersListViewController
            finalController.usersListViewModel = viewModel
            finalController.transitioningDelegate = self
            
        }
    }
}

extension UsersListViewController: UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .push {
            return FlipPresentAnimationControllerViewController(originFrame: self.view.frame)
        } else {
            return FlipDismissAnimationViewController(destinationFrame: self.view.frame)
        }
        
    }
}
