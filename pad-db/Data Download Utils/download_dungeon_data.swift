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

func getFloors(for dungeon: Dungeon) -> [FloorListItem] {
    if let data = Just.get(floor_list_api_hook + String(dungeon.dungeonID)).content {
        do {
            let floors = try JSONDecoder().decode([FloorListItem].self, from: data)
            return floors
        } catch let error as NSError {
            print(error)
        }
    }
    return []
}

func getFloor(forID id:Int, floorNumber num:Int) -> Floor? {
    var floor:Floor?
    if let data = Just.get(getFloorHook(for: id, onFloor: num)).content {
        do {
            floor = try JSONDecoder().decode(Floor.self, from: data)
            return floor
        } catch let error as NSError {
            print(error)
        }
    }
    return floor
}

func getFloorHook(for dungeonID:Int, onFloor floorNumber:Int) -> String {
    return floor_api_hook + String(dungeonID) + "/" + String(floorNumber)
}
