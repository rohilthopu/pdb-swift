//
//  DownloadEncounterData.swift
//  pad-db
//
//  Created by Rohil Thopu on 2/21/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SwiftyJSON

func getEncounterData() {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "EncounterSet", in: managedContext)!
    
    if let url = URL(string: encounter_api_url) {
        if let data = try? String(contentsOf: url) {
            let json = JSON(parseJSON: data)
            for floor in json.arrayValue {
                let item = NSManagedObject(entity: entity, insertInto: managedContext)
                item.setValue(floor["floor_id"].intValue, forKey: "floorNumber")
                item.setValue(floor["encounter_data"].stringValue, forKey: "encounterData")
                item.setValue(floor["dungeon_id"].intValue, forKey: "dungeonID")
                item.setValue(floor["wave_number"].intValue, forKey: "wave")
            }
        }
        
        do {
            try managedContext.save()
        }
        catch _ as NSError {
            print("Error saving floors in CoreData")
        }
    }
}
