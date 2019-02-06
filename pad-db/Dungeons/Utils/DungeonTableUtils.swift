//
//  File.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/24/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension DungeonListTableViewController {
    func setupView() {
        self.navigationItem.title = "Dungeons"
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }
    
    func makeLabel(ofSize size: CGFloat, withText text: String) -> UILabel {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: size)
        textView.clipsToBounds = true
        textView.text = text
        textView.textAlignment = .center
        textView.adjustsFontSizeToFitWidth = true
        return textView
    }
    
    func setupSearch() {
        dungeonSearch = UISearchController(searchResultsController: nil)
        dungeonSearch.searchResultsUpdater = self
        dungeonSearch.obscuresBackgroundDuringPresentation = false
        dungeonSearch.searchBar.placeholder = "Search Dungeons"
        if #available(iOS 11.0, *) {
            navigationItem.searchController = dungeonSearch
        } else {
            // Fallback on earlier versions
            self.tableView.tableHeaderView = dungeonSearch.searchBar
        }
        dungeonSearch.isActive = true
        dungeonSearch.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        self.dungeonSearch.delegate = self
        self.dungeonSearch.searchBar.delegate = self
//        self.extendedLayoutIncludesOpaqueBars = true
        
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredDungeons = dungeons.filter{
            return ($0.value(forKey: "name") as! String).lowercased().contains(searchText.lowercased())
        }
        tableView.reloadData()
    }
    
    func isFiltering() -> Bool {
        return dungeonSearch.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return dungeonSearch.searchBar.text?.isEmpty ?? true
    }

}