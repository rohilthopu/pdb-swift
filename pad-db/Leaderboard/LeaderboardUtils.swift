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
    
    func downloadLeaderboardData() {
        if let url = URL(string: link) {
            if let data = try? String(contentsOf: url) {
                let json = JSON(parseJSON: data)
                for item in json.arrayValue {
                    var user:User = User()
                    
                    user.user = item["author"].stringValue
                    user.score = item["score"].intValue
                    user.scoreUp = item["scoreUp"].boolValue
                    user.scoreDown = item["scoreDown"].boolValue
                    user.scoreDiff = item["scoreDiff"].intValue
                    
            
                    users.append(user)
                }
            }
        }
        users.sort(by: {$0.score! > $1.score!})
    }
    
    
    // SEARCH CONTROLLER FUNCTIONS
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return userSearch.searchBar.text?.isEmpty ?? true
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
