//
//  SkillTableUtils.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/14/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension SkillTableVC {
    func setupNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        navigationItem.title = "Skill"
    }
    
    func setupTableView() {
        self.definesPresentationContext = true
        self.extendedLayoutIncludesOpaqueBars = true
    }
    
    func setupSearch() {
        skillSearch = UISearchController(searchResultsController: nil)
        skillSearch.searchResultsUpdater = self
        skillSearch.obscuresBackgroundDuringPresentation = false
        skillSearch.searchBar.placeholder = "Search Skills"
        navigationItem.searchController = skillSearch
        skillSearch.isActive = true
        skillSearch.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        self.skillSearch.delegate = self
        self.skillSearch.searchBar.delegate = self
        self.extendedLayoutIncludesOpaqueBars = true
        
    }
    
    func filterUsableSkills() -> [NSManagedObject]{
        var goodSkills = [NSManagedObject]()
        
        for skill in skills {
            let c = skill.value(forKey: "cSkill1") as! Int
            if c != -1 {
                goodSkills.append(skill)
            }
        }
        
        goodSkills.sort{
            let first = $0.value(forKey: "skillID") as! Int
            let second = $1.value(forKey: "skillID") as! Int
            
            return first > second
        }
        
        return goodSkills
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredSkills = goodSkills.filter({
            let val = $0.value(forKey: "name") as! String
            let skillID = $0.value(forKey: "skillID") as! Int
            let id = String(skillID)
            let desc = $0.value(forKey: "desc") as! String
            let searchQuery = searchText.lowercased()
            return val.lowercased().contains(searchQuery) || id.contains(searchQuery) || desc.lowercased().contains(searchQuery)
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return skillSearch.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return skillSearch.searchBar.text?.isEmpty ?? true
    }
}
