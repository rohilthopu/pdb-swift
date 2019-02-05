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
