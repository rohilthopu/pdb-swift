//
//  LeaderboardUtils.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/13/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

extension LeaderboardTableVC {

    // SEARCH CONTROLLER FUNCTIONS
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return userSearch.searchBar.text?.isEmpty ?? true
    }
    
    @objc
    func changeSort() {
        if isDescending {
            isDescending = false
            users.sort(by: { $0.score! < $1.score! })
            tableView.reloadData()
        }
        else {
            isDescending = true
            users.sort(by: { $0.score! > $1.score! })
            tableView.reloadData()
        }
    }
    
    
    func filterContentForText(_ searchText: String, scope: String = "All") {
        filteredUsers = users.filter({
            let val = $0.user!
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
        return userSearch.isActive && !searchBarIsEmpty()
    }
}
