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

var naDungeons = [Guerrilla]()
var jpDungeons = [Guerrilla]()
var displayDungeons = [Guerrilla]()
var showingNA = true
var runUpdate = true

let version_api_url = "https://www.pad-db.com/api/version/"

var versions = [NSManagedObject]()
var newVersions:[String: Int] = [:]


class GuerrillaTableViewController: UITableViewController {
    
    let cellid = "guerrillacell"
    let vc = LoadDataVC()
    let vc2 = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl!.addTarget(self, action: #selector(refreshGuerrillaList(_:)), for: .valueChanged)
        tableView.register(GuerrillaCell.self, forCellReuseIdentifier: cellid)
        tableView.rowHeight = 85
        tableView.allowsSelection = false
        self.definesPresentationContext = true
        
        setupNavBar()
        loadGuerrilla()
        loadFromDB()
        tableView.reloadData()
        
        vc.view.backgroundColor = UIColor.black
        vc.view.alpha = CGFloat(0.75)
        vc.view.isOpaque = false
        
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        vc.view.backgroundColor = UIColor.white
        vc.view.center = self.tableView.center
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if runUpdate {
            checkVersion()
            self.present(vc, animated: true, completion: nil)
        }
    }
    // MARK: - Table view data source
    
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
        return cell
    }
    
}
