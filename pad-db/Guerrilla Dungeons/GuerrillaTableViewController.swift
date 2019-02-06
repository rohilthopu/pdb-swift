//
//  GuerrillaTableViewController.swift
//  pad-db
//
//  Created by Rohil Thopu on 12/19/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

class GuerrillaTableViewController: UITableViewController {
    
    let cellid = "guerrillacell"
    let vc = LoadDataVC()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl!.addTarget(self, action: #selector(refreshGuerrillaList(_:)), for: .valueChanged)
        tableView.register(GuerrillaCell.self, forCellReuseIdentifier: cellid)
        tableView.rowHeight = 85
        self.definesPresentationContext = true
        
        setupNavBar()
        loadFromDB()
        loadGuerrilla()
        
        vc.view.backgroundColor = UIColor.black
        vc.view.alpha = CGFloat(0.75)
        vc.view.isOpaque = false
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.view.backgroundColor = UIColor.white
        vc.view.center = self.tableView.center
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if runUpdate {
            checkVersion()
            self.present(vc, animated: true, completion: nil)
        }
        updateGuerrillaViewNA()
        updateGuerrillaViewJP()
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayDungeons.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! GuerrillaCell
        
        let dungeon = displayDungeons[indexPath.row]
        cell.name = dungeon.name!
        cell.group = dungeon.group!
        cell.status = dungeon.status!
        cell.remainingTime = dungeon.remainingTime!
        if let imgLink = dungeon.imgLink {
            cell.imgLink = imgLink
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let gDungeon = displayDungeons[index]
        let currentDungeon = getDungeon(forID: gDungeon.dungeon_id!)
        
        if let currentDungeon = currentDungeon {
            let floorListTable = DungeonTableViewController()
            floorListTable.dungeon_floors = getFloors(for: currentDungeon)
            floorListTable.navigationItem.title = (currentDungeon.value(forKey: "name") as! String)
            self.navigationController?.pushViewController(floorListTable, animated: true)
        }
    }
    
}
