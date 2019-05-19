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

func getMonster(forID id:Int) -> Monster? {
    return monsters.filter({
        return id == $0.cardID
    }).first
}

func getMonster(forSkillID id:Int) -> Monster? {
    return monsters.filter({
        let aSkill = $0.activeSkillID
        let lSkill = $0.leaderSkillID
        return id == aSkill || id == lSkill
    }).last
}

func getSkill(forSkill id:Int) -> Skill {
    return skills.filter({
        return id == $0.skillID
    }).first!
}

func getFloors(for dungeon: NSManagedObject) -> [NSManagedObject] {
    return floors.filter{ ($0.value(forKey: "dungeonID") as! Int) == (dungeon.value(forKey: "dungeonID") as! Int) }.sorted {
        let first = $0.value(forKey: "floorNumber") as! Int
        let second = $1.value(forKey: "floorNumber") as! Int
        return first > second
    }
}

func getDungeon(forID id:Int) -> NSManagedObject? {
    return dungeons.filter{($0.value(forKey: "dungeonID") as! Int) == id}.first
}

func getFloor(forID id:Int, floorNumber num:Int) -> NSManagedObject? {
    return floors.filter{($0.value(forKey: "dungeonID") as! Int) == id && ($0.value(forKey: "floorNumber") as! Int) == num }.first
}

func getMessages(forFloor floor:NSManagedObject) -> [JSON] {
    return JSON(parseJSON: floor.value(forKey: "messages") as! String).arrayValue
}

func getPossibleDrops(forFloor floor:NSManagedObject) -> [String:JSON] {
    return JSON(parseJSON: floor.value(forKey: "possibleDrops") as! String).dictionaryValue
}

func getFixedTeam(forFloor floor:NSManagedObject) -> [String:JSON] {
    return JSON(parseJSON: floor.value(forKey: "fixedTeam") as! String).dictionaryValue
}

func getAwakenings(forMonster monster:NSManagedObject) -> [Int] {
    return JSON(parseJSON: monster.value(forKey: "awakenings") as! String).arrayValue.map{ $0.intValue }
}

func getSuperAwakenings(forMonster monster:NSManagedObject) -> [Int] {
    return JSON(parseJSON: monster.value(forKey: "superAwakenings") as! String).arrayValue.map{ $0.intValue }
}

func getEvoList(forMonster monster:NSManagedObject) -> [Int] {
    return JSON(parseJSON: monster.value(forKey: "evolutions") as! String).arrayValue.map{ $0.intValue }
}

func getEnemySkills(forMonster monster:Monster) -> [NSManagedObject] {
    let eSkills = monster.enemySkillRefs.reversed()
    return enemySkills.filter { eSkills.contains($0.value(forKey: "enemy_skill_id") as! Int) }
}

func getRelatedDungeons(forMonster monster:Monster) -> [NSManagedObject] {
    var relatedDungeons = [NSManagedObject]()
    let id = monster.cardID
    for floor in floors {
        let drops = getPossibleDrops(forFloor: floor)
        if let _ = drops[id.description] {
            let d = dungeons.filter{
                return $0.value(forKey: "dungeonID") as! Int == floor.value(forKey: "dungeonID") as! Int
                }.first
            if let d = d {
                if !relatedDungeons.contains(d) {
                    relatedDungeons.append(d)
                }
            }
        }
    }
    return relatedDungeons
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
func checkVersion() {
    if let url = URL(string: version_api_url) {
        if let data = try? String(contentsOf: url) {
            let json = JSON(parseJSON: data).arrayValue
            for v in json {
                newVersions["monster"] = v["monster"].intValue
            }
        }
    }
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

func validateCardID(forID cardID:Int) -> Int {
    if cardID / 100000 > 0 {
        return cardID % 100000
    }
    return cardID
}
