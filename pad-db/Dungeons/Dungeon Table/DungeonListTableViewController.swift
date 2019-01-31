//
//  DungeonTableViewController.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/24/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher

var dungeons = [NSManagedObject]()
var floors = [NSManagedObject]()

extension DungeonListTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class DungeonListTableViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    let cellid = "dungeoncell"
    var filteredDungeons = [NSManagedObject]()
    var dungeonSearch:UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSearch()
        self.tableView.register(DungeonCell.self, forCellReuseIdentifier: cellid)
        self.tableView.rowHeight = 100
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering() {
            return filteredDungeons.count
        }
        return dungeons.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! DungeonCell
        
        if isFiltering() {
            cell.dungeon = filteredDungeons[indexPath.row]
        } else {
            cell.dungeon = dungeons[indexPath.row]

        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        var currentDungeon:NSManagedObject
        
        if isFiltering() {
            currentDungeon = filteredDungeons[index]
        } else {
            currentDungeon = dungeons[index]
        }
        
        let floorListTable = DungeonTableViewController()
        floorListTable.dungeon_floors = getFloors(for: currentDungeon)
//        let titleLabel = makeLabel(ofSize: 16, withText: (currentDungeon.value(forKey: "name") as! String))
//        floorListTable.navigationItem.titleView = titleLabel
        floorListTable.navigationItem.title = (currentDungeon.value(forKey: "name") as! String)
        self.navigationController?.pushViewController(floorListTable, animated: true)
        
    }

}
