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
import CoreData

func getDungeonData() {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Dungeon", in: managedContext)!
    
    if let url = URL(string: dungeon_api_url) {
        if let data = try? String(contentsOf: url) {
            let json = JSON(parseJSON: data)
            for dungeon in json.arrayValue {
                
                let item = NSManagedObject(entity: entity, insertInto: managedContext)
                item.setValue(dungeon["name"].stringValue, forKey: "name")
                item.setValue(dungeon["dungeonID"].intValue, forKey: "dungeonID")
                item.setValue(dungeon["dungeonType"].stringValue, forKey: "dungeonType")
                item.setValue(dungeon["floorCount"].intValue, forKey: "floorCount")
                item.setValue(dungeon["imageID"].intValue, forKey: "imageID")
                dungeons.append(item)
                
            }
        }
    }
    
    do {
        try managedContext.save()
    }
    catch _ as NSError {
        print("Error saving dungeons in CoreData")
    }
}

func getFloorData() {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Floor", in: managedContext)!
    
    if let url = URL(string: floor_api_url) {
        if let data = try? String(contentsOf: url) {
            let json = JSON(parseJSON: data)
            for floor in json.arrayValue {
                
                
                let item = NSManagedObject(entity: entity, insertInto: managedContext)
                item.setValue(floor["floorNumber"].intValue, forKey: "floorNumber")
                item.setValue(floor["name"].stringValue, forKey: "name")
                item.setValue(floor["stamina"].intValue, forKey: "stamina")
                item.setValue(floor["waves"].intValue, forKey: "waves")
                item.setValue(floor["possibleDrops"].stringValue, forKey: "possibleDrops")
                item.setValue(floor["dungeonID"].intValue, forKey: "dungeonID")
                item.setValue(floor["requiredDungeon"].intValue, forKey: "requiredDungeon")
                item.setValue(floor["requiredFloor"].intValue, forKey: "requiredFloor")
                item.setValue(floor["encounterModifiers"].stringValue, forKey: "encounterModifiers")
                item.setValue(floor["teamModifiers"].stringValue, forKey: "teamModifiers")
                item.setValue(floor["entryRequirement"].stringValue, forKey: "entryRequirement")
                item.setValue(floor["messages"].stringValue, forKey: "messages")
                item.setValue(floor["score"].intValue, forKey: "score")
                item.setValue(floor["fixedTeam"].stringValue, forKey: "fixedTeam")
                item.setValue(floor["enhancedType"].stringValue, forKey: "enhancedType")
                item.setValue(floor["enhancedAttribute"].stringValue, forKey: "enhancedAttribute")
                item.setValue(floor["imageID"].intValue, forKey: "imageID")
                
                floors.append(item)
                
            }
        }
    }
    
    do {
        try managedContext.save()
    }
    catch _ as NSError {
        print("Error saving floors in CoreData")
    }
}
