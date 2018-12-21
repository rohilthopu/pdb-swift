//
//  GuerrillaTableViewController.swift
//  pad-db
//
//  Created by Rohil Thopu on 12/19/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit
import SwiftyJSON


struct Guerrilla {
    var name:String?
    var startTime:String?
    var endTime:String?
    var startSecs:Float?
    var endSecs:Float?
    var server:String?
    var group:String?
    var dungeon_id:Int?
    var remainingTime:Float?
    var status:String?
}


class GuerrillaTableViewController: UITableViewController {
    
    let cellid = "guerrillacell"
    
    

    var naDungeons = [Guerrilla]()
    var jpDungeons = [Guerrilla]()
    
    var displayDungeons = [Guerrilla]()
    
    var showingNA = false


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupNavBar()
    
        tableView.register(GuerrillaCell.self, forCellReuseIdentifier: cellid)
        tableView.rowHeight = 85
    
        tableView.allowsSelection = false
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadGuerrilla()
    }
    
    
    private func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.gray
        navigationItem.title = "NA Calendar"
        
        changeButtonLabel(server: "Server")
        
    }
    
    @objc
    private func swapServer(sender: UIButton!) {
        
        if showingNA {
            displayDungeons = jpDungeons
            showingNA = false
            navigationItem.title = "JP Calendar"
            self.tableView.reloadData()
        }
        else {
            displayDungeons = naDungeons
            showingNA = true
            navigationItem.title = "NA Calendar"
            self.tableView.reloadData()
        }
    }
    
    private func changeButtonLabel(server:String) {
        let serverSwap = UIButton(type: .system)
        serverSwap.setTitle(server, for: .normal)
        serverSwap.addTarget(self, action: #selector(swapServer), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: serverSwap)
    }
    
    private func loadGuerrilla() {
        let url = "https://www.pad-db.com/api/guerrilla"
        let timeInMS = Float(NSTimeIntervalSince1970)

        if let url = URL(string: url) {
            if let data = try? String(contentsOf: url) {
                let json = JSON(parseJSON: data)
                for item in json.arrayValue {
                    var dungeon:Guerrilla = Guerrilla()
                    dungeon.name = item["name"].stringValue
                    dungeon.startTime = item["startTime"].stringValue
                    dungeon.endTime = item["endTime"].stringValue
                    dungeon.startSecs = item["startSecs"].floatValue
                    dungeon.endSecs = item["endSecs"].floatValue
                    dungeon.server = item["server"].stringValue
                    dungeon.group = item["group"].stringValue
                    dungeon.dungeon_id = item["dungeon_id"].intValue
                    
                    let endSecs = item["endSecs"].floatValue
                    let startSecs = item["startSecs"].floatValue

                    
                    if ((timeInMS >= startSecs) && (timeInMS <= endSecs)) {
                        dungeon.remainingTime = endSecs - timeInMS
                        dungeon.status = "Active"
                    }
                    else if (timeInMS < startSecs) {
                        dungeon.remainingTime = startSecs - timeInMS
                        dungeon.status = "Upcoming"
                    }
                    else {
                        dungeon.remainingTime = 0
                        dungeon.status = "Ended"
                    }
                    
                
                    if item["server"].stringValue == "NA" {
                        naDungeons.append(dungeon)
                    }
                    else {
                        jpDungeons.append(dungeon)
                    }
                }
            }
        }
        
        
        
        displayDungeons = naDungeons
        showingNA = true
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
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
