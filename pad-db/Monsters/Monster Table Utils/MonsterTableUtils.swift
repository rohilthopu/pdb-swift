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
    func loadLiveData() {
        monsters.removeAll()
        skills.removeAll()
        clearDB()
        tableView.reloadData()
        let activity = UIActivityIndicatorView(style: .gray)
        tableView.addSubview(activity)
        activity.frame = tableView.bounds
        
        tableView.reloadData()
        activity.startAnimating()
        
        DispatchQueue.global(qos: .background).async {
            self.getMonsterData()
            self.getSkillData()
            DispatchQueue.main.async {
                self.saveMonsterData()
                self.saveSkillData()
                self.loadMonstersFromDB()
                self.loadSkillsFromDB()
                activity.stopAnimating()
                activity.removeFromSuperview()
                self.tableView.reloadData()
            }
        }
    }
    
    func clearDB() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MonsterNA")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "SkillNA")
        let deleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        
        
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.execute(deleteRequest2)
            try managedContext.save()
        } catch {
            print("There was an error deleting items.")
        }
    }
    
    // SEARCH CONTROLLER FUNCTIONS
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return monstersearch.searchBar.text?.isEmpty ?? true
    }
    
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMonsters = monsters.filter({
            let val = $0.value(forKey: "name") as! String
            if val.lowercased().contains(searchText.lowercased()){
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
    
    //    Misc
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/255.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/255.0
        let blue = CGFloat(rgbValue & 0xFF)/255.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
    func getPortraitURL(id:Int) -> String {
        return portrait_url + String(id) + ".png"
    }
    
    func getFullURL(id:Int) -> String {
        return full_url + String(id) + ".png"
    }
}
