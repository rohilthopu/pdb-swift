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

func getDungeon(forID id:Int) -> Dungeon? {
    return dungeons.filter{($0.dungeonID) == id}.first
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


func parseJsonIntList(forString data:String) -> [Int] {
    return JSON(parseJSON: data).arrayValue.map{ $0.intValue }
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
