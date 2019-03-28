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

extension DungeonTable: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class DungeonTable: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    let cellid = "dungeoncell"
    var filteredDungeons = [NSManagedObject]()
    var dungeonSearch:UISearchController!
    var goodDungeons = [NSManagedObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSearch()
        self.tableView.register(DungeonCell.self, forCellReuseIdentifier: cellid)
        self.tableView.rowHeight = 80
        getGoodDungeons()
        
    }
    
    private func getGoodDungeons() {
        if naFilter {
            goodDungeons = dungeons.filter {
                if let server = $0.value(forKey: "server") as! String? {
                    return server == "na"
                }
                return true
            }
        } else {
            goodDungeons = dungeons
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if changeSettings {
            getGoodDungeons()
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredDungeons.count
        }
        return goodDungeons.count
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
            cell.dungeon = goodDungeons[indexPath.row]

        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        var currentDungeon:NSManagedObject
        
        if isFiltering() {
            currentDungeon = filteredDungeons[index]
        } else {
            currentDungeon = goodDungeons[index]
        }
        let floorListTable = FloorTable()
        floorListTable.dungeon_floors = getFloors(for: currentDungeon)
        floorListTable.navigationItem.title = (currentDungeon.value(forKey: "name") as! String)
        self.navigationController?.pushViewController(floorListTable, animated: true)
    }
}
