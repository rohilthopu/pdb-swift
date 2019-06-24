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
    
    let cellid = "leadercell"
    
    var filteredUsers = [User]()
    
    var userSearch:UISearchController!
    
    var isDescending:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.register(LeaderboardCell.self, forCellReuseIdentifier: cellid)
        tableView.allowsSelection = false
        
        tableView.rowHeight = 100
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl!.addTarget(self, action: #selector(refreshLeaderboardList(_:)), for: .valueChanged)
        
        setupNavBar()
        setupView()
        
        downloadLeaderboardData()
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    
    @objc
    private func refreshLeaderboardList(_ sender: Any) {
        users.removeAll()
        tableView.reloadData()
        downloadLeaderboardData()
        tableView.refreshControl?.endRefreshing()
        self.tableView.reloadData()
    }
    
    private func setupView() {
        
        userSearch = UISearchController(searchResultsController: nil)
        
        userSearch.searchResultsUpdater = self
        userSearch.obscuresBackgroundDuringPresentation = false
        userSearch.searchBar.placeholder = "Search Users"
        userSearch.searchBar.barStyle = UIBarStyle.blackTranslucent
        if #available(iOS 11.0, *) {
            navigationItem.searchController = userSearch
        } else {
            // Fallback on earlier versions
            self.tableView.tableHeaderView = userSearch.searchBar
        }
        userSearch.isActive = false
        userSearch.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        self.userSearch.delegate = self
        self.userSearch.searchBar.delegate = self
        self.extendedLayoutIncludesOpaqueBars = true
        
    }
    
    private func setupNavBar() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        navigationItem.title = "Karma Leaderboard"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "order")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(changeSort))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
