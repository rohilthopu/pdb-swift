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
            if isDescendedSort {
                isDescendedSort = false
                sortMonstersAscending()
                tableView.reloadData()
            }
            else {
                isDescendedSort = true
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
            dungeons.removeAll()
            tableView.reloadData()
            clearDB()
        }
    }
    
    @objc
    func clearDB() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
        let managedContext = appDelegate.persistentContainer.viewContext

        
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MonsterNA")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "SkillNA")
        let deleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        
        let fetchRequest3 = NSFetchRequest<NSFetchRequestResult>(entityName: "Dungeon")
        let deleteRequest3 = NSBatchDeleteRequest(fetchRequest: fetchRequest3)
        
        let fetchRequest4 = NSFetchRequest<NSFetchRequestResult>(entityName: "Floor")
        let deleteRequest4 = NSBatchDeleteRequest(fetchRequest: fetchRequest4)
        
        let fetchRequest5 = NSFetchRequest<NSFetchRequestResult>(entityName: "EnemySkill")
        let deleteRequest5 = NSBatchDeleteRequest(fetchRequest: fetchRequest5)
        
        
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.execute(deleteRequest2)
            try managedContext.execute(deleteRequest3)
            try managedContext.execute(deleteRequest4)
            try managedContext.execute(deleteRequest5)
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
        return monsterSearchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForText(_ searchText: String, scope: String = "All") {
        
        let tokenText:Set = Set(searchText.lowercased().split(separator: " ").map{$0})
        filteredMonsters = goodMonsters.filter({
            let val = Set(($0.value(forKey: "name") as! String).lowercased().split(separator: " ").map{$0})
            let id = String($0.value(forKey: "cardID") as! Int)
            return tokenText.isSubset(of: val) || id == searchText.lowercased()
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return monsterSearchController.isActive && !searchBarIsEmpty()
    }

}
