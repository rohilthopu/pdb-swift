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
            
            if newVersions["monster"]! > localMonsterVersion || monsters.count == 0 {
                getMonsterData()
                getEnemySkillData()
            }
            
            if newVersions["skill"]! > localSkillVersion || skills.count == 0 {
                getSkillData()
            }
            
            if newVersions["dungeon"]! > localDungeonVersion || dungeons.count == 0 {
                getDungeonData()
                getFloorData()
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
        loadGuerrilla()
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
    
}
