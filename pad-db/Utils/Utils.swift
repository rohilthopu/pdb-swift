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

func makeView() -> UIView {
    let vw = UIView()
    vw.translatesAutoresizingMaskIntoConstraints = false
    vw.clipsToBounds = true
    return vw
}

func makeSeparator() -> UIView {
    let separator = UIView()
    separator.translatesAutoresizingMaskIntoConstraints = false
    separator.clipsToBounds = true
    separator.layer.borderWidth = 1
    separator.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    separator.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 3 / 4).isActive = true
    return separator
}

func makeImgView(forImg link:String, ofSize size:CGFloat) -> UIImageView {
    let img = UIImageView()
    img.translatesAutoresizingMaskIntoConstraints = false
    img.clipsToBounds = true
    img.kf.setImage(with: URL(string: link))
    img.widthAnchor.constraint(equalToConstant: size).isActive = true
    img.heightAnchor.constraint(equalToConstant: size).isActive = true
    img.layer.cornerRadius = 3
    
    return img
}

func makeImgView(fromIconName icon:String, ofSize size:CGFloat) -> UIImageView {
    let img = UIImageView()
    img.translatesAutoresizingMaskIntoConstraints = false
    img.clipsToBounds = true
    img.image = UIImage(named: icon)
    img.heightAnchor.constraint(equalToConstant: size).isActive = true
    img.widthAnchor.constraint(equalToConstant: size).isActive = true
    
    return img
}

func makeLabel(ofSize size: CGFloat, withText text: String) -> UILabel {
    let textView = UILabel()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.font = UIFont(name: "Futura-CondensedMedium", size: size)
    textView.clipsToBounds = true
    textView.text = text
    return textView
}

func getMonster(forID id:Int) -> NSManagedObject {
    return monsters.filter({
        return id == $0.value(forKey: "cardID") as! Int
    }).first!
}

func getMonster(forSkillID id:Int) -> NSManagedObject? {
    return monsters.filter({
        let aSkill = $0.value(forKey: "activeSkillID") as! Int
        let lSkill = $0.value(forKey: "leaderSkillID") as! Int
        return id == aSkill || id == lSkill
    }).last
}

func getSkill(forSkill id:Int) -> NSManagedObject {
    return skills.filter({
        return id == $0.value(forKey: "skillID") as! Int
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

func getEnemySkills(forMonster monster:NSManagedObject) -> [NSManagedObject] {
    let eSkillsRaw = monster.value(forKey: "enemySkills") as! String
    let eSkills = JSON(parseJSON: eSkillsRaw).arrayValue.map{$0.intValue}.sorted{ $0 < $1 }
    return enemySkills.filter { eSkills.contains($0.value(forKey: "enemy_skill_id") as! Int) }
}

func getRelatedDungeons(forMonster monster:NSManagedObject) -> [NSManagedObject] {
    var relatedDungeons = [NSManagedObject]()
    let id = monster.value(forKey: "cardID") as! Int
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

func checkVersion() {
    if let url = URL(string: version_api_url) {
        if let data = try? String(contentsOf: url) {
            let json = JSON(parseJSON: data).arrayValue
            for v in json {
                newVersions["dungeon"] = v["dungeon"].intValue
                newVersions["monster"] = v["monster"].intValue
                newVersions["skill"] = v["skill"].intValue
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

func loadFromDB() {
    
    guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
            return
    }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let monsterRequest = NSFetchRequest<NSManagedObject>(entityName: "MonsterNA")
    let monsterRequestSort = NSSortDescriptor(key: "cardID", ascending: false)
    monsterRequest.sortDescriptors = [monsterRequestSort]
    
    let skillRequest = NSFetchRequest<NSManagedObject>(entityName: "SkillNA")
    let skillRequestSort = NSSortDescriptor(key: "skillID", ascending: false)
    skillRequest.sortDescriptors = [skillRequestSort]
    
    let versionRequest = NSFetchRequest<NSManagedObject>(entityName: "Version")
    let dungeonRequest = NSFetchRequest<NSManagedObject>(entityName: "Dungeon")
    dungeonRequest.sortDescriptors = [NSSortDescriptor(key: "dungeonID", ascending: false)]
    
    let floorRequest = NSFetchRequest<NSManagedObject>(entityName: "Floor")
    let enemySkillRequest = NSFetchRequest<NSManagedObject>(entityName: "EnemySkill")
    
    
    do {
        monsters = try managedContext.fetch(monsterRequest)
        skills = try managedContext.fetch(skillRequest)
        versions = try managedContext.fetch(versionRequest)
        dungeons = try managedContext.fetch(dungeonRequest)
        floors = try managedContext.fetch(floorRequest)
        enemySkills = try managedContext.fetch(enemySkillRequest)
    } catch _ as NSError {
        print("Could not fetch.")
    }
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