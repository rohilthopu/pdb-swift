//
//  DataCollectionUtils.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/17/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SwiftyJSON
import Kingfisher


extension GuerrillaTableViewController {
    
    func getAllIds() {
        monsterIDList.removeAll()
        skillIDList.removeAll()
        for monster in monsters {
            monsterIDList[monster.value(forKey: "cardID") as! Int] = 1
        }
        for skill in skills {
            skillIDList[skill.value(forKey: "skillID") as! Int] = 1
        }
    }
    
    func sortMonstersDescending() {
        monsters.sort{
            let first = $0.value(forKey: "cardID") as! Int
            let second = $1.value(forKey: "cardID") as! Int
            
            return first > second
        }
    }
    
    func sortMonstersAscending() {
        monsters.sort{
            let first = $0.value(forKey: "cardID") as! Int
            let second = $1.value(forKey: "cardID") as! Int
            
            return first < second
        }
    }
    
    func sortSkillsDescending() {
        skills.sort{
            let first = $0.value(forKey: "skillID") as! Int
            let second = $1.value(forKey: "skillID") as! Int
            
            return first > second
        }
    }
    
    func getMonsterData() {
        
        rawMonsters.removeAll()
        // Source: https://mrgott.com/swift-programing/33-rest-api-in-swift-4-using-urlsession-and-jsondecode
        // load the url
        
        
        if let url = URL(string: monster_url) {
            if let data = try? String(contentsOf: url) {
                let json = JSON(parseJSON: data).arrayValue
                
                if json.count > monsters.count {
                    for card in json {
                        
                        
                        var monster:Monster = Monster()
                        monster.activeSkillID = card["activeSkillID"].intValue
                        monster.leaderSkillID = card["leaderSkillID"].intValue
                        
                        monster.ancestorID = card["ancestorID"].intValue
                        monster.attributeID = card["attributeID"].intValue
                        
                        let decoder = JSONDecoder()
                        let vals = try! decoder.decode([Int].self, from: card["awakenings_raw"].stringValue.data(using: .utf8)!)
                        monster.awakenings = vals
                        
                        let evoVals = try! decoder.decode([Int].self, from: card["evos_raw"].stringValue.data(using: .utf8)!)
                        monster.evolutions = evoVals
                        
                        
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
                        monster.isUlt = card["isUlt"].boolValue
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
                        
                        monster.portraitLink = getPortraitURL(id: monster.cardID!)
                        monster.fullLink = getFullURL(id: monster.cardID!)
                        
                        
                        monster.sellMP = card["sellMP"].intValue
                        monster.sellCoin = card["sellCoin"].intValue
                        
                        rawMonsters.append(monster)
                        
                    }
                    
                }
                    
                else {
                    runUpdate = false
                }
                
            }
        }
        
    }
    
    func getPortraitURL(id:Int) -> String {
        return portrait_url + String(id) + ".png"
    }
    
    func getFullURL(id:Int) -> String {
        return full_url + String(id) + ".png"
    }
    
}
