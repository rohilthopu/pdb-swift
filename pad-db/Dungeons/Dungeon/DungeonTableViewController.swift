//
//  DungeonTableViewController.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/28/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit
import CoreData

class DungeonTableViewController: UITableViewController {
    
    var dungeon_floors = [NSManagedObject]()
    
    let cellid = "floorcell"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 100
        self.tableView.register(DungeonFloorCell.self, forCellReuseIdentifier: cellid)
        self.tableView.allowsSelection = false
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! DungeonFloorCell
        cell.floor = dungeon_floors[indexPath.row]
        return cell
    }

}
