//
//  DungeonTableViewController.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/28/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit
import CoreData

class FloorTable: UITableViewController {
    
    var dungeon_floors = [FloorListItem]()
    
    let cellid = "floorcell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 100
        self.tableView.register(FloorCell.self, forCellReuseIdentifier: cellid)
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dungeon_floors.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! FloorCell
        cell.floor = dungeon_floors[indexPath.row]
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let floorVC = WaveTable()
//        floorVC.floor =  dungeon_floors[indexPath.row]
//        floorVC.navigationItem.title = "Enemy Waves"
//        self.navigationController?.pushViewController(floorVC, animated: true)
//    }

}
