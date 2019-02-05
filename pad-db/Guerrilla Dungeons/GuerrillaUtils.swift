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
        dungeonRequest.sortDescriptors = [NSSortDescriptor(key: "dungeonID", ascending: false)]
    
        let floorRequest = NSFetchRequest<NSManagedObject>(entityName: "Floor")
        let enemySkillRequest = NSFetchRequest<NSManagedObject>(entityName: "EnemySkill")

        
        do {
            monsters = try managedContext.fetch(monsterRequest)
            skills = try managedContext.fetch(skillRequest)
            versions = try managedContext.fetch(versionRequest)
            dungeons = try managedContext.fetch(dungeonRequest)
            floors = try managedContext.fetch(floorRequest)
            enemySkills = try managedContext.fetch(enemySkillRequest)

            
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
        let server = UIBarButtonItem(image: UIImage(named: "world")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(swapServer))
        let settings = UIBarButtonItem(image: UIImage(named: "settings")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(showSettings))
        
        let items = [server, settings]
        
        navigationItem.rightBarButtonItems = items
    }
    
    @objc
    func showSettings() {
        let settings = SettingsViewController()
        self.navigationController?.pushViewController(settings, animated: true)
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
            loadGuerrilla()
            
            DispatchQueue.main.async {
                self.tableView.refreshControl!.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
}
