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
    var remainingTime:Double?
    var status:String?
}


class GuerrillaTableViewController: UITableViewController {

    
    let cellid = "guerrillacell"
    
    

    var naDungeons = [Guerrilla]()
    var jpDungeons = [Guerrilla]()
    
    var displayDungeons = [Guerrilla]()
    
    var showingNA = true


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupNavBar()
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl!.addTarget(self, action: #selector(refreshGuerrillaList(_:)), for: .valueChanged)

    
        tableView.register(GuerrillaCell.self, forCellReuseIdentifier: cellid)
        tableView.rowHeight = 85
    
        tableView.allowsSelection = false
        loadGuerrilla()

        tableView.reloadData()
    }
    
    
    private func setupNavBar() {
        if #available(iOS 11, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        navigationItem.title = "NA Calendar"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "world")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(swapServer))        
    }
    
    @objc
    private func swapServer() {
        
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
    
    @objc
    private func refreshGuerrillaList(_ sender: Any) {
        naDungeons.removeAll()
        jpDungeons.removeAll()
        tableView.reloadData()
        
        DispatchQueue.global(qos: .background).async {
            self.loadGuerrilla()

            DispatchQueue.main.async {
                self.tableView.refreshControl!.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    
    private func loadGuerrilla() {
        let url = "https://www.pad-db.com/api/guerrilla"
        let timeInMS = NSDate().timeIntervalSince1970

        if let url = URL(string: url) {
            if let data = try? String(contentsOf: url) {
                let json = JSON(parseJSON: data)
                for item in json.arrayValue {
                    var dungeon:Guerrilla = Guerrilla()
              
                    
                    let endSecs = item["endSecs"].doubleValue
                    let startSecs = item["startSecs"].doubleValue
                    
                                        
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
                    
                    
                    if dungeon.remainingTime! != 0 {
                        dungeon.name = item["name"].stringValue
                        dungeon.startTime = item["startTime"].stringValue
                        dungeon.endTime = item["endTime"].stringValue
                        dungeon.startSecs = item["startSecs"].floatValue
                        dungeon.endSecs = item["endSecs"].floatValue
                        dungeon.server = item["server"].stringValue
                        dungeon.group = item["group"].stringValue
                        dungeon.dungeon_id = item["dungeon_id"].intValue
                        
                        
                        if item["server"].stringValue == "NA" {
                            naDungeons.append(dungeon)
                        }
                        else {
                            jpDungeons.append(dungeon)
                        }
                    }

                }
            }
        }
        
        if showingNA {
            displayDungeons = naDungeons
        }
        else {
            displayDungeons = jpDungeons
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
