//
//  LoadDataVC.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/17/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON
import CoreData

class LoadDataVC: UIViewController {
    
    let updateLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLabel.translatesAutoresizingMaskIntoConstraints = false
        updateLabel.clipsToBounds = true
        updateLabel.font = UIFont(name: "Futura-CondensedMedium", size: 20)
        updateLabel.text = "Downloading data..."
        self.view.addSubview(updateLabel)
        updateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        updateLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getAllIds()
        getNewData()
        self.dismiss(animated: true, completion: nil)
    }

    func getNewData() {
        if let v = versions.first {
            let localMonsterVersion = v.value(forKey: "monster") as! Int
            let localSkillVersion = v.value(forKey: "skill") as! Int
            let localDungeonVersion = v.value(forKey: "dungeon") as! Int
//            let localDungeonVersion = v.value(forKey: "monster") as! Int
            
            if newVersions["monster"]! > localMonsterVersion || monsters.count == 0 {
                getMonsterData()
            }
            
            if newVersions["skill"]! > localSkillVersion || skills.count == 0 {
                getSkillData()
            }
            
            if newVersions["dungeon"]! > localDungeonVersion || dungeons.count == 0 {
                getDungeonData()
            }
        } else if monsters.count == 0 {
            getMonsterData()
            getSkillData()
        }
        
        saveMonsterData()
        saveSkillData()
        sortMonstersDescending()
        sortSkillsDescending()
        updateVersionIdentifier()
        runUpdate = false
    }
    
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
    
    func sortSkillsDescending() {
        skills.sort{
            let first = $0.value(forKey: "skillID") as! Int
            let second = $1.value(forKey: "skillID") as! Int
            
            return first > second
        }
    }
    
    func saveMonsterData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MonsterNA", in: managedContext)!
        
        
        for monster in rawMonsters {
            
            if let id = monster.cardID {
                if monsterIDList[id] == nil {
                    
                    let item = NSManagedObject(entity: entity, insertInto: managedContext)
                    item.setValue(monster.activeSkillID, forKey: "activeSkillID")
                    item.setValue(monster.ancestorID, forKey: "ancestorID")
                    item.setValue(monster.attributeID, forKey: "attributeID")
                    item.setValue(monster.awakenings, forKey: "awakenings")
                    item.setValue(monster.cardID, forKey: "cardID")
                    item.setValue(monster.cost, forKey: "cost")
                    item.setValue(monster.evolutions, forKey: "evolutions")
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
                    item.setValue(monster.isUlt, forKey: "isUlt")
                    item.setValue(monster.leaderSkillID, forKey: "leaderSkillID")
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
                    
                    item.setValue(monster.sellMP, forKey: "sellMP")
                    item.setValue(monster.sellCoin, forKey: "sellCoin")
                    
                    monsters.append(item)
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
    
    func getMonsterData() {

        
        if let url = URL(string: monsterLink) {
            if let data = try? String(contentsOf: url) {
                let json = JSON(parseJSON: data).arrayValue
                
                for card in json {
                    
                    let name = card["name"].stringValue
                    if !name.isEmpty {
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
            }
        }
        
    }
    
    func getSkillData() {
        
        if let url = URL(string: skill_api_link) {
            if let data = try? String(contentsOf: url) {
                let json = JSON(parseJSON: data)
                for item in json.arrayValue {
                    
                    var skill:Skill = Skill()
                    skill.name = item["name"].stringValue
                    skill.description = item["description"].stringValue
                    skill.skillID = item["skillID"].int
                    skill.skillType = item["skill_type"].stringValue
                    skill.hpMult = item["hp_mult"].floatValue
                    skill.atkMult = item["atk_mult"].floatValue
                    skill.rcvMult = item["rcv_mult"].floatValue
                    skill.dmgReduction = item["dmg_reduction"].doubleValue
                    skill.cSkill1 = item["c_skill_1"].intValue
                    skill.cSkill2 = item["c_skill_2"].intValue
                    skill.cSkill3 = item["c_skill_3"].intValue
                    skill.skillClass = item["skill_class"].stringValue
                    skill.levels = item["levels"].intValue
                    skill.minTurns = item["minTurns"].intValue
                    skill.maxTurns = item["maxTurns"].intValue
                    
                    rawSkills.append(skill)
                }
            }
        }
    }
    
    func getDungeonData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Dungeon", in: managedContext)!
        
        if let url = URL(string: dungeon_api_url) {
            if let data = try? String(contentsOf: url) {
                let json = JSON(parseJSON: data)
                for dungeon in json.arrayValue {
                    
                    
                    let item = NSManagedObject(entity: entity, insertInto: managedContext)
                    item.setValue(dungeon["name"].stringValue, forKey: "name")
                    item.setValue(dungeon["dungeonID"].intValue, forKey: "dungeonID")
                    item.setValue(dungeon["dungeonType"].stringValue, forKey: "dungeonType")
                    item.setValue(dungeon["floorCount"].intValue, forKey: "floorCount")
                    
                    dungeons.append(item)
                    
                }
            }
        }
        
        do {
            try managedContext.save()
        }
        catch _ as NSError {
            print("Error saving dungeons in CoreData")
        }
    }
    
    func saveSkillData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "SkillNA", in: managedContext)!
        
        for skill in rawSkills {
            if let id = skill.skillID {
                if skillIDList[id] == nil {
                    let item = NSManagedObject(entity: entity, insertInto: managedContext)
                    item.setValue(skill.name, forKey: "name")
                    item.setValue(skill.description, forKey: "desc")
                    item.setValue(skill.skillID, forKey: "skillID")
                    item.setValue(skill.skillType, forKey: "skillType")
                    item.setValue(skill.hpMult, forKey: "hpMult")
                    item.setValue(skill.atkMult, forKey: "atkMult")
                    item.setValue(skill.rcvMult, forKey: "rcvMult")
                    item.setValue(skill.dmgReduction, forKey: "dmgReduction")
                    item.setValue(skill.cSkill1, forKey: "cSkill1")
                    item.setValue(skill.cSkill2, forKey: "cSkill2")
                    item.setValue(skill.cSkill3, forKey: "cSkill3")
                    item.setValue(skill.skillClass, forKey: "skillClass")
                    item.setValue(skill.levels, forKey: "levels")
                    item.setValue(skill.minTurns, forKey: "minTurns")
                    item.setValue(skill.maxTurns, forKey: "maxTurns")
                    skills.append(item)
                }
            }
            
            
        }
        do {
            try managedContext.save()
        }
        catch _ as NSError {
            print("Error saving skills in CoreData")
        }
    }
    
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
    
    func getPortraitURL(id:Int) -> String {
        return portrait_url + String(id) + ".png"
    }
    
    func getFullURL(id:Int) -> String {
        return full_url + String(id) + ".png"
    }
}
