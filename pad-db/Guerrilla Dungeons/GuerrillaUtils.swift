//
//  GuerrillaUtils.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/17/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

extension GuerrillaTableViewController {
    
    func checkVersion() {
        if let url = URL(string: version_api_url) {
            if let data = try? String(contentsOf: url) {
                let json = JSON(parseJSON: data).arrayValue
                for v in json {
                    newVersions["dungeon"] = v["dungeon"].intValue
                    newVersions["monster"] = v["monster"].intValue
                    newVersions["skill"] = v["skill"].intValue
                }
            }
        }
    }
    
    func loadFromDB() {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let monsterRequest = NSFetchRequest<NSManagedObject>(entityName: "MonsterNA")
        let monsterRequestSort = NSSortDescriptor(key: "cardID", ascending: false)
        monsterRequest.sortDescriptors = [monsterRequestSort]
        
        
        
        let skillRequest = NSFetchRequest<NSManagedObject>(entityName: "SkillNA")
        let skillRequestSort = NSSortDescriptor(key: "skillID", ascending: false)
        skillRequest.sortDescriptors = [skillRequestSort]
        
        
        let versionRequest = NSFetchRequest<NSManagedObject>(entityName: "Version")
        
        let dungeonRequest = NSFetchRequest<NSManagedObject>(entityName: "Dungeon")
        let floorRequest = NSFetchRequest<NSManagedObject>(entityName: "Floor")
        
        let dungeonRequestSort = NSSortDescriptor(key: "dungeonID", ascending: false)
        dungeonRequest.sortDescriptors = [dungeonRequestSort]
        
        do {
            monsters = try managedContext.fetch(monsterRequest)
            skills = try managedContext.fetch(skillRequest)
            versions = try managedContext.fetch(versionRequest)
            dungeons = try managedContext.fetch(dungeonRequest)
            floors = try managedContext.fetch(floorRequest)
            
        } catch _ as NSError {
            print("Could not fetch.")
        }
    }
    
    func setupNavBar() {
        if #available(iOS 11, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        navigationItem.title = "NA Calendar"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "world")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(swapServer))
    }
    
    @objc
    func swapServer() {
        
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
    func refreshGuerrillaList(_ sender: Any) {
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
    
    func loadGuerrilla() {
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
}

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
