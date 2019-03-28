//
//  DownloadMonsterData.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/31/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

func getMonsterData() {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "MonsterNA", in: managedContext)!
    
    if let url = URL(string: monster_url) {
        if let data = try? String(contentsOf: url) {
            let json = JSON(parseJSON: data).arrayValue
            
            for card in json {
                
                let name = card["name"].stringValue
                if !name.isEmpty {

                    let item = NSManagedObject(entity: entity, insertInto: managedContext)
                    item.setValue(card["activeSkillID"].intValue, forKey: "activeSkillID")
                    item.setValue(card["ancestorID"].intValue, forKey: "ancestorID")
                    item.setValue(card["attributeID"].int, forKey: "attributeID")
                    
                    item.setValue(card["awakenings_raw"].stringValue, forKey: "awakenings")
                    item.setValue(card["cardID"].intValue, forKey: "cardID")
                    item.setValue(card["cost"].intValue, forKey: "cost")
                    item.setValue(card["evos_raw"].stringValue, forKey: "evolutions")
                    item.setValue(card["evomat1"].intValue, forKey: "evomat1")
                    item.setValue(card["evomat2"].intValue, forKey: "evomat2")
                    item.setValue(card["evomat3"].intValue, forKey: "evomat3")
                    item.setValue(card["evomat4"].intValue, forKey: "evomat4")
                    item.setValue(card["evomat5"].intValue, forKey: "evomat5")
                    item.setValue(card["unevomat1"].intValue, forKey: "unevomat1")
                    item.setValue(card["unevomat2"].intValue, forKey: "unevomat2")
                    item.setValue(card["unevomat3"].intValue, forKey: "unevomat3")
                    item.setValue(card["unevomat4"].intValue, forKey: "unevomat4")
                    item.setValue(card["unevomat5"].intValue, forKey: "unevomat5")
                    item.setValue(card["isUlt"].boolValue, forKey: "isUlt")
                    item.setValue(card["leaderSkillID"].intValue, forKey: "leaderSkillID")
                    item.setValue(card["maxATK"].intValue, forKey: "maxATK")
                    item.setValue(card["maxHP"].intValue, forKey: "maxHP")
                    item.setValue(card["maxRCV"].intValue, forKey: "maxRCV")
                    item.setValue(card["minATK"].intValue, forKey: "minATK")
                    item.setValue(card["minHP"].intValue, forKey: "minHP")
                    item.setValue(card["minRCV"].intValue, forKey: "minRCV")
                    item.setValue(card["maxLevel"].intValue, forKey: "maxLevel")
                    item.setValue(card["maxXP"].intValue, forKey: "maxXP")
                    item.setValue(card["name"].stringValue, forKey: "name")
                    item.setValue(card["rarity"].intValue, forKey: "rarity")
                    item.setValue(card["subAttributeID"].intValue, forKey: "subAttributeID")
                    item.setValue(card["superAwakenings_raw"].stringValue, forKey: "superAwakenings")
                    item.setValue(card["type1"].intValue, forKey: "type1")
                    item.setValue(card["type2"].intValue, forKey: "type2")
                    item.setValue(card["type3"].intValue, forKey: "type3")
                    
                    item.setValue(card["sellMP"].intValue, forKey: "sellMP")
                    item.setValue(card["sellCoin"].intValue, forKey: "sellCoin")
                    
                    item.setValue(card["enemy_skills"].stringValue, forKey: "enemySkills")
                    item.setValue(card["server"].stringValue, forKey: "server")
                    
                }
            }
        }
        do {
            try managedContext.save()
        }
        catch _ as NSError {
            print("Error saving monsters in CoreData")
        }
    }
    
}
