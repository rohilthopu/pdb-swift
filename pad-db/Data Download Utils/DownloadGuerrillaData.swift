//
//  DownloadGuerrillaData.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/31/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

func loadGuerrilla() {
    let url = "https://www.pad-db.com/api/guerrilla"
    let timeInMS = NSDate().timeIntervalSince1970
    
    allGuerrillaDungeons.removeAll()
    
    if let url = URL(string: url) {
        if let data = try? String(contentsOf: url) {
            let json = JSON(parseJSON: data)
            for item in json.arrayValue {
                var dungeon:Guerrilla = Guerrilla()
                
                
                let endSecs = item["endSecs"].doubleValue
                let startSecs = item["startSecs"].doubleValue
                
                
                if ((timeInMS >= startSecs) && (timeInMS <= endSecs)) {
                    dungeon.remainingTime = (endSecs - timeInMS)
                    dungeon.status = "Active"
                }
                else if (timeInMS < startSecs) {
                    dungeon.remainingTime = startSecs - timeInMS
                    dungeon.status = "Upcoming"
                }
                else {
                    dungeon.remainingTime = 0
                }
                
                if dungeon.remainingTime! != 0 {
                    dungeon.name = item["name"].stringValue
                    dungeon.startTime = item["startTime"].stringValue
                    dungeon.endTime = item["endTime"].stringValue
                    dungeon.startSecs = item["startSecs"].floatValue
                    dungeon.endSecs = item["endSecs"].floatValue
                    dungeon.server = item["server"].stringValue
                    dungeon.group = item["group"].stringValue
                    dungeon.dungeon_id = item["dungeon_id"].intValue
                    dungeon.imgLink = getPortraitURL(id: item["image_id"].intValue)
                    allGuerrillaDungeons.append(dungeon)
                }
            }
        }
    }
    
    updateGuerrillaViewNA()
    updateGuerrillaViewJP()
}
