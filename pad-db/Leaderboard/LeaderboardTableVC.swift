//
//  LeaderboardTableVCTableViewController.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/13/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit

extension  LeaderboardTableVC: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForText(searchController.searchBar.text!)
    }
}

class LeaderboardTableVC: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate{
    
    let link = "https://www.pad-db.com/api/leaderboard"
    
    let cellid = "leadercell"
    
    var users = [User]()
    var filteredUsers = [User]()
    
    var userSearch:UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(LeaderboardCell.self, forCellReuseIdentifier: cellid)
        tableView.allowsSelection = false
        
        tableView.rowHeight = 100
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl!.addTarget(self, action: #selector(refreshLeaderboardList(_:)), for: .valueChanged)
        
        setupNavBar()
        setupView()
        
        tableView.refreshControl?.beginRefreshing()
        DispatchQueue.global(qos: .background).async {
            self.downloadLeaderboardData()
            
            DispatchQueue.main.async {
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
        
        
        
        tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    @objc
    private func refreshLeaderboardList(_ sender: Any) {
        users.removeAll()
        tableView.reloadData()
        
        DispatchQueue.global(qos: .background).async {
            self.downloadLeaderboardData()
            
            DispatchQueue.main.async {
                self.tableView.refreshControl!.endRefreshing()
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    
    private func setupView() {
        
        userSearch = UISearchController(searchResultsController: nil)
        
        userSearch.searchResultsUpdater = self
        userSearch.obscuresBackgroundDuringPresentation = false
        userSearch.searchBar.placeholder = "Search Users"
        navigationItem.searchController = userSearch
        userSearch.isActive = false
        userSearch.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        self.userSearch.delegate = self
        self.userSearch.searchBar.delegate = self
        self.extendedLayoutIncludesOpaqueBars = true
        
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        navigationItem.title = "Karma Leaderboard"
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        if isFiltering() {
            return filteredUsers.count
        }
        return users.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! LeaderboardCell
        
        if isFiltering() {
            cell.user = filteredUsers[indexPath.row]
            cell.rank = users.firstIndex(where: {$0.user! == filteredUsers[indexPath.row].user!})
            return cell
        }
        cell.user = users[indexPath.row]
        cell.rank = indexPath.row + 1
        return cell
    }
    
    
    
    
}
