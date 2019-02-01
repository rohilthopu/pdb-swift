//
//  DownloadVersionIdentifier.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/31/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

func updateVersionIdentifier() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "Version", in: managedContext)!
    if let v = versions.first {
        v.setValue(newVersions["monster"], forKey: "monster")
        v.setValue(newVersions["skill"], forKey: "skill")
        v.setValue(newVersions["dungeon"], forKey: "dungeon")
    } else {
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(newVersions["monster"], forKey: "monster")
        item.setValue(newVersions["skill"], forKey: "skill")
        item.setValue(newVersions["dungeon"], forKey: "dungeon")
    }
    do {
        try managedContext.save()
    }
    catch _ as NSError {
        print("Error saving version identifier in CoreData")
    }
}
