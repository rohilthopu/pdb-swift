//
//  MonsterTableUtils.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/11/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SwiftyJSON
import Kingfisher

extension MonsterTableController {
    
    func loadMonstersFromDB() {
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "MonsterNA")
        
        let sort = NSSortDescriptor(key: "cardID", ascending: false)
        fetchRequest.sortDescriptors = [sort]
        
        do {
            monsters = try managedContext.fetch(fetchRequest)
//            monsters.reverse()
        } catch _ as NSError {
            print("Could not fetch.")
        }
    }
    
    
    
    func saveMonsterData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MonsterNA", in: managedContext)!
        
        
        for monster in rawMonsters {
            let item = NSManagedObject(entity: entity, insertInto: managedContext)
            item.setValue(monster.activeSkillID, forKey: "activeSkillID")
            item.setValue(monster.ancestorID, forKey: "ancestorID")
            item.setValue(monster.attributeID, forKey: "attributeID")
            item.setValue(monster.awakenings, forKey: "awakenings")
            item.setValue(monster.cardID, forKey: "cardID")
            item.setValue(monster.cost, forKey: "cost")
            item.setValue(monster.evomat1, forKey: "evomat1")
            item.setValue(monster.evomat2, forKey: "evomat2")
            item.setValue(monster.evomat3, forKey: "evomat3")
            item.setValue(monster.evomat4, forKey: "evomat4")
            item.setValue(monster.evomat5, forKey: "evomat5")
            item.setValue(monster.unevomat1, forKey: "unevomat1")
            item.setValue(monster.unevomat2, forKey: "unevomat2")
            item.setValue(monster.unevomat3, forKey: "unevomat3")
            item.setValue(monster.unevomat4, forKey: "unevomat4")
            item.setValue(monster.unevomat5, forKey: "unevomat5")
            item.setValue(monster.maxATK, forKey: "maxATK")
            item.setValue(monster.maxHP, forKey: "maxHP")
            item.setValue(monster.maxRCV, forKey: "maxRCV")
            item.setValue(monster.minATK, forKey: "minATK")
            item.setValue(monster.minHP, forKey: "minHP")
            item.setValue(monster.minRCV, forKey: "minRCV")
            item.setValue(monster.maxLevel, forKey: "maxLevel")
            item.setValue(monster.maxXP, forKey: "maxXP")
            item.setValue(monster.name, forKey: "name")
            item.setValue(monster.rarity, forKey: "rarity")
            item.setValue(monster.subAttributeID, forKey: "subAttributeID")
            item.setValue(monster.superAwakenings, forKey: "superAwakenings")
            item.setValue(monster.type1, forKey: "type1")
            item.setValue(monster.type2, forKey: "type2")
            item.setValue(monster.type3, forKey: "type3")
            item.setValue(monster.portraitLink, forKey: "portraitURL")
            item.setValue(monster.fullLink, forKey: "fullURL")
            
            
            do {
                try managedContext.save()
            }
            catch _ as NSError {
                print("Error saving monster in CoreData")
            }
        }
    }
    
    func getMonsterData() {
        
        // Source: https://mrgott.com/swift-programing/33-rest-api-in-swift-4-using-urlsession-and-jsondecode
        // load the url
        
        if let url = URL(string: self.monster_url) {
            if let data = try? String(contentsOf: url) {
                let json = JSON(parseJSON: data)
                
                for card in json.arrayValue {
                    
                    let name = card["name"].stringValue
                    if !name.contains("?") && !name.contains("*") && !name.isEmpty && !name.contains("Alt.") {
                        var monster:Monster = Monster()
                        monster.activeSkillID = card["activeSkillID"].intValue
                        monster.leaderSkillID = card["leaderSkillID"].intValue
                        
                        monster.ancestorID = card["ancestorID"].intValue
                        monster.attributeID = card["attributeID"].intValue
                        
                        let decoder = JSONDecoder()
                        let vals = try! decoder.decode([Int].self, from: card["awakenings_raw"].stringValue.data(using: .utf8)!)
                        monster.awakenings = vals
                        
                        
                        monster.cardID = card["cardID"].intValue
                        monster.cost = card["cost"].intValue
                        monster.unevomat1 = card["unevomat1"].intValue
                        monster.unevomat2 = card["unevomat2"].intValue
                        monster.unevomat3 = card["unevomat3"].intValue
                        monster.unevomat4 = card["unevomat4"].intValue
                        monster.unevomat5 = card["unevomat5"].intValue
                        monster.evomat1 = card["evomat1"].intValue
                        monster.evomat2 = card["evomat2"].intValue
                        monster.evomat3 = card["evomat3"].intValue
                        monster.evomat4 = card["evomat4"].intValue
                        monster.evomat5 = card["evomat5"].intValue
                        monster.maxATK = card["maxATK"].intValue
                        monster.maxHP = card["maxHP"].intValue
                        monster.maxRCV = card["maxRCV"].intValue
                        monster.minATK = card["minATK"].intValue
                        monster.minHP = card["minHP"].intValue
                        monster.minRCV = card["minRCV"].intValue
                        monster.maxXP = card["maxXP"].intValue
                        monster.maxLevel = card["maxLevel"].intValue
                        monster.name = card["name"].stringValue
                        monster.rarity = card["rarity"].intValue
                        monster.subAttributeID = card["subAttributeID"].intValue
                        
                        
                        let vals2 = try! decoder.decode([Int].self, from: card["superAwakenings_raw"].stringValue.data(using: .utf8)!)
                        monster.superAwakenings = vals2
                        
                        
                        monster.type1 = card["type1"].intValue
                        monster.type2 = card["type2"].intValue
                        monster.type3 = card["type3"].intValue
                        
                        monster.portraitLink = self.getPortraitURL(id: monster.cardID!)
                        monster.fullLink = self.getFullURL(id: monster.cardID!)
                        
                        self.rawMonsters.append(monster)
                    }
                }
            }
        }
    }
}
