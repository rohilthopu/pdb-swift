//
//  DatabaseUtils.swift
//  pad-db
//
//  Created by Rohil Thopu on 2/22/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

func loadFromDB() {
    
    guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
            return
    }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let versionRequest = NSFetchRequest<NSManagedObject>(entityName: "Version")
    let dungeonRequest = NSFetchRequest<NSManagedObject>(entityName: "Dungeon")
    dungeonRequest.sortDescriptors = [NSSortDescriptor(key: "dungeonID", ascending: false)]
    
    let floorRequest = NSFetchRequest<NSManagedObject>(entityName: "Floor")
    let enemySkillRequest = NSFetchRequest<NSManagedObject>(entityName: "EnemySkill")
    
    let encounterRequest = NSFetchRequest<NSManagedObject>(entityName: "EncounterSet")
    
    do {
        versions = try managedContext.fetch(versionRequest)
        dungeons = try managedContext.fetch(dungeonRequest)
        floors = try managedContext.fetch(floorRequest)
        enemySkills = try managedContext.fetch(enemySkillRequest)
        encounterSets = try managedContext.fetch(encounterRequest)
    } catch _ as NSError {
        print("Could not fetch.")
    }
}


func wipeDatabase() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MonsterNA")
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    let fetchRequest2 = NSFetchRequest<NSFetchRequestResult>(entityName: "SkillNA")
    let deleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
    
    let fetchRequest3 = NSFetchRequest<NSFetchRequestResult>(entityName: "Dungeon")
    let deleteRequest3 = NSBatchDeleteRequest(fetchRequest: fetchRequest3)
    
    let fetchRequest4 = NSFetchRequest<NSFetchRequestResult>(entityName: "Floor")
    let deleteRequest4 = NSBatchDeleteRequest(fetchRequest: fetchRequest4)
    
    let fetchRequest5 = NSFetchRequest<NSFetchRequestResult>(entityName: "EnemySkill")
    let deleteRequest5 = NSBatchDeleteRequest(fetchRequest: fetchRequest5)
    
    let fetchRequest6 = NSFetchRequest<NSFetchRequestResult>(entityName: "EncounterSet")
    let deleteRequest6 = NSBatchDeleteRequest(fetchRequest: fetchRequest6)
    
    
    do {
        try managedContext.execute(deleteRequest)
        try managedContext.execute(deleteRequest2)
        try managedContext.execute(deleteRequest3)
        try managedContext.execute(deleteRequest4)
        try managedContext.execute(deleteRequest5)
        try managedContext.execute(deleteRequest6)
        try managedContext.save()
    } catch {
        print("There was an error deleting items.")
    }
}
