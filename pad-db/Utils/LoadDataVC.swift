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
        if !newVersions.isEmpty {
            getNewData()
        } else {
            runUpdate = false
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func getNewData() {
        if let v = versions.first {
            let localMonsterVersion = v.value(forKey: "monster") as! Int
            let localSkillVersion = v.value(forKey: "skill") as! Int
            let localDungeonVersion = v.value(forKey: "dungeon") as! Int
            
            if newVersions["monster"]! > localMonsterVersion || newVersions["skill"]! > localSkillVersion || newVersions["dungeon"]! > localDungeonVersion || monsters.count == 0 {
                // force rebuild for now. saves effort and guarantees most recent data
                goodSkills.removeAll()
                goodMonsters.removeAll()
                wipeDatabase()
                getData()
            }
        } else if monsters.count == 0 {
            // this would be a first run type of scenario, or if a db rebuild failed
            getData()
        }
        updateVersionIdentifier()
        loadFromDB()
        
        runUpdate = false
    }
    
    func getData() {
        getMonsterData()
        getEnemySkillData()
        getSkillData()
        getDungeonData()
        getFloorData()
        getEncounterData()
    }
}
