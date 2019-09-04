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
    var filteredDungeons = [Dungeon]()
    var dungeonSearch:UISearchController!
    var goodDungeons = [Dungeon]()

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
                return $0.server == "NA"
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
        var currentDungeon:Dungeon
        
        if isFiltering() {
            currentDungeon = filteredDungeons[index]
        } else {
            currentDungeon = goodDungeons[index]
        }
        let floorListTable = FloorTable()
        floorListTable.dungeon_floors = getFloors(for: currentDungeon)
        floorListTable.navigationItem.title = (currentDungeon.name)
        self.navigationController?.pushViewController(floorListTable, animated: true)
    }
}
