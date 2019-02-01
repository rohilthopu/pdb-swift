//
//  DownloadLeaderboardData.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/31/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

func downloadLeaderboardData() {
    if let url = URL(string: leaderboardLink) {
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
