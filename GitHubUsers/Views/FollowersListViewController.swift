//
//  FollowersListViewController.swift
//  GitHubUsers
//
//  Created by Yevgenii Pasko on 4/6/18.
//  Copyright © 2018 Yevgenii Pasko. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh

class FollowersListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var usersListViewModel: FollowersListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // settings for navbar
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "\(Constants.FollowersListTitle): \(usersListViewModel?.userName ?? "")"
        self.navigationController?.navigationBar.backgroundColor = UIColor.cyan
        self.navigationController?.navigationBar.tintColor = UIColor.lightGray
        
        // enchatments of UI reloading
        self.addingPullToRefresh()
        
        // subscribing nib to controller
        let nib = UINib(nibName: "UserListTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: Constants.FollowersListCellIndetifier)
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = UITableViewAutomaticDimension
        usersListViewModel?.reloadTableBlock = {[weak self] in
            self?.tableView.dg_stopLoading()
            self?.tableView.reloadData()
        }
        self.tableView.reloadData()
    }

    func addingPullToRefresh() {
        
        // Initialize tableView
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            
            self?.usersListViewModel?.refreshData()
            }, loadingView: loadingView)
        tableView.dg_setPullToRefreshFillColor(UIColor.lightGray)
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        tableView.dg_removePullToRefresh()
    }
}

extension FollowersListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard let count = usersListViewModel?.usersArray.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.FollowersListCellIndetifier) as? UserListTableViewCell else {
            return UITableViewCell()
        }
        self.configurateCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    private func configurateCell(cell: UserListTableViewCell, indexPath: IndexPath) {
        
        guard let user = usersListViewModel?.usersArray[indexPath.row] else {
            return
        }
        cell.setUserPropertiesData(user: user)
    }
}

extension FollowersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (usersListViewModel?.usersArray.count)!-20 == indexPath.row {
            usersListViewModel?.loadData(perPage: 30)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: Constants.FollowersItselfSegue, sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.FollowersSegue || segue.identifier == Constants.FollowersItselfSegue {
            let indexPath = sender as? IndexPath ?? IndexPath()
            let viewModel = usersListViewModel?.createFollowersListViewModel(indexPath: indexPath)
            let finalController = segue.destination as! FollowersListViewController
            finalController.usersListViewModel = viewModel
        }
    }
}

