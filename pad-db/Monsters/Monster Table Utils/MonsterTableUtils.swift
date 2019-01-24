//
//  MonsterTableUtils.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/11/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension MonsterTableController {
    
    @objc
    func changeSort() {
        
        if !isRefreshing {
            if isDesc {
                isDesc = false
                sortMonstersAscending()
                tableView.reloadData()
            }
            else {
                isDesc = true
                sortMonstersDescending()
                tableView.reloadData()
            }
        }
        
    }
    
    @objc
    func clearDBAndReloadView() {
        
        if !isRefreshing {
            monsters.removeAll()
            skills.removeAll()
            goodSkills.removeAll()
            goodMonsters.removeAll()
            tableView.reloadData()
            clearDB()
        }
    }
    
    @objc
    func clearDB() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Version", in: managedContext)!

        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MonsterNA")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "SkillNA")
        let deleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        
        
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(1, forKey: "monster")
        item.setValue(1, forKey: "skill")
        item.setValue(1, forKey: "dungeon")
                
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.execute(deleteRequest2)
            try managedContext.save()
        } catch {
            print("There was an error deleting items.")
        }
    }
    
    func sortMonstersDescending() {
        goodMonsters.sort{
            let first = $0.value(forKey: "cardID") as! Int
            let second = $1.value(forKey: "cardID") as! Int
            
            return first > second
        }
    }
    
    func sortMonstersAscending() {
        goodMonsters.sort{
            let first = $0.value(forKey: "cardID") as! Int
            let second = $1.value(forKey: "cardID") as! Int
            
            return first < second
        }
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return monstersearch.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForText(_ searchText: String, scope: String = "All") {
        filteredMonsters = goodMonsters.filter({
            let val = $0.value(forKey: "name") as! String
            let id = String($0.value(forKey: "cardID") as! Int)
            if val.lowercased().contains(searchText.lowercased()) || id.contains(searchText.lowercased()) {
                return true
            }
            else {
                return false
            }
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return monstersearch.isActive && !searchBarIsEmpty()
    }

}
