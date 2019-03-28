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

extension SkillTable {
    func setupNavBar() {
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
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
        skillSearch.searchBar.barStyle = UIBarStyle.blackTranslucent

        if #available(iOS 11.0, *) {
            navigationItem.searchController = skillSearch
        } else {
            // Fallback on earlier versions
            self.tableView.tableHeaderView = skillSearch.searchBar
        }
        skillSearch.isActive = true
        skillSearch.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        self.skillSearch.delegate = self
        self.skillSearch.searchBar.delegate = self
        self.extendedLayoutIncludesOpaqueBars = true
        
    }
    
    func filterUsableSkills() -> [NSManagedObject] {
        return skills.filter{
            if naFilter {
                return $0.value(forKey: "cSkill1") as! Int != -1 && $0.value(forKey: "server") as! String == "na"
            }
            return $0.value(forKey: "cSkill1") as! Int != -1
        }
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        let searchTextAsTokenList = getTokenList(forSearchQuery: searchText)
        filteredSkills = goodSkills.filter({
            let val = getTokenList(forSearchQuery: $0.value(forKey: "name") as! String)
            let skillID = $0.value(forKey: "skillID") as! Int
            let id = String(skillID)
            let desc = ($0.value(forKey: "desc") as! String).lowercased()
            return searchTextAsTokenList.isSubset(of: val) || id.contains(searchText.lowercased()) || desc.contains(searchText.lowercased())
        })
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return skillSearch.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        return skillSearch.searchBar.text?.isEmpty ?? true
    }
}
