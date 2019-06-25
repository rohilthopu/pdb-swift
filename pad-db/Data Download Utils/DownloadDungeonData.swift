//
//  DownloadDungeonData.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/31/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import Just

func getLiveDungeonData() {
    
    if let data = Just.get(dungeon_list_api_hook).content {
        do {
            dungeons = try JSONDecoder().decode([Dungeon].self, from: data).reversed()
        } catch let error as NSError {
            print(error)
        }
    }
}
