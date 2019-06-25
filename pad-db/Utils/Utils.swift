//
//  Utils.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/30/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SwiftyJSON
import Just

func getMonster(forID id:Int) -> MonsterListItem? {
    return monsters.filter({
        return id == $0.cardID
    }).first
}

func getMonster(forSkillID id:Int) -> MonsterListItem? {
    return monsters.filter({
        let aSkill = $0.activeSkillID
        let lSkill = $0.leaderSkillID
        return id == aSkill || id == lSkill
    }).first
}

func getMonsterFromAPI(cardID:Int) -> Monster? {
    var monster:Monster?
    let monsterURL = "http://192.168.1.102:8000/api/monster/" + String(cardID)
    if let data = Just.get(monsterURL).content {
        do {
            monster = try JSONDecoder().decode(Monster.self, from: data)
        } catch let error as NSError {
            print(error)
        }
    }
    
    return monster
}

func getSkill(forSkill id:Int) -> Skill? {
    let skillURL = "http://192.168.1.102:8000/api/skill/" + String(id)
    var skill:Skill?
    if let data = Just.get(skillURL).content {
        do {
            skill = try JSONDecoder().decode(Skill.self, from: data)
            return skill
        } catch let error as NSError {
            print(error)
        }
    }
    return skill
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

func getDungeon(forID id:Int) -> Dungeon? {
    return dungeons.filter{($0.dungeonID) == id}.first
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

func getMessages(forFloor floor:Floor) -> [String] {
    return JSON(parseJSON: floor.messages).arrayValue.map{ $0.stringValue }
}

func getPossibleDrops(forFloor floor:Floor) -> [String:JSON] {
    return JSON(parseJSON: floor.possibleDrops).dictionaryValue
}

func getFixedTeam(forFloor floor:Floor) -> [[String:JSON]] {
    return JSON(parseJSON: floor.fixedTeam).arrayValue.map{$0.dictionaryValue}
}

func getEvoList(forMonster monster:Monster) -> [Dictionary<String, JSON>] {
    return JSON(parseJSON: monster.evolutions).arrayValue.map{ $0.dictionaryValue }
}

func getEnemySkills(forMonster monster:Monster) -> [NSManagedObject] {
    let eSkills = JSON(parseJSON: monster.enemySkills).arrayValue.map{ $0.intValue }.reversed()
    return enemySkills.filter { eSkills.contains($0.value(forKey: "enemy_skill_id") as! Int) }
}

func parseJsonIntList(forString data:String) -> [Int] {
    return JSON(parseJSON: data).arrayValue.map{ $0.intValue }
}

func getRelatedDungeons(forMonster monster:Monster) -> [Int] {
    return JSON(parseJSON: monster.relatedDungeons).arrayValue.map{ $0.intValue }
}

func getPortraitURL(id:Int) -> String {
    return portrait_url + String(id) + pngEngding
}

func getFullURL(id:Int) -> String {
    return full_url + String(id) + pngEngding
}

func getNAGroup() -> String? {
    return UserDefaults.standard.string(forKey: "nagroup")
}

func getJPGroup() -> String? {
    return UserDefaults.standard.string(forKey: "jpgroup")
}

func getRegion() -> String? {
    return UserDefaults.standard.string(forKey: "region")
}

func updateGuerrillaViewNA() {
    if currGroupNA != "None" {
        naDungeons = allGuerrillaDungeons.filter{ $0.group!.lowercased() == currGroupNA.lowercased() && $0.server! == "NA" }
    } else {
        naDungeons = allGuerrillaDungeons.filter{$0.server! == "NA" }
    }
    if showingNA {
        displayDungeons = naDungeons
    }
}

func updateGuerrillaViewJP() {
    if currGroupJP != "None" {
        jpDungeons = allGuerrillaDungeons.filter{ $0.group!.lowercased() == currGroupJP.lowercased() && $0.server! == "JP" }
    } else {
        jpDungeons = allGuerrillaDungeons.filter{$0.server! == "JP" }
    }
    if !showingNA {
        displayDungeons = jpDungeons
    }
}

func getTokenList(forSearchQuery text:String) -> Set<String> {
    return Set(text.lowercased().split(separator: " ").map{ String($0) })
}
