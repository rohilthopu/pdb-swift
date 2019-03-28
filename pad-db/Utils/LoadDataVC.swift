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
    
    private func getNewData() {
        if let v = versions.first {
            if isNewVersion(currentVersion: v) || isMissingData() {
                // force rebuild for now. saves effort and guarantees most recent data
                getData()
                updateVersionIdentifier()
                loadFromDB()
            }
        }

        runUpdate = false
    }
    
    private func getData() {
        goodSkills.removeAll()
        goodMonsters.removeAll()
        wipeDatabase()
        getMonsterData()
        getEnemySkillData()
        getSkillData()
        getDungeonData()
        getFloorData()
        getEncounterData()
    }
    
    private func isNewVersion(currentVersion v:NSManagedObject) -> Bool {
        let localMonsterVersion = v.value(forKey: "monster") as! Int        
        return newVersions["monster"]! > localMonsterVersion
    }
    
    private func isMissingData() -> Bool {
        return monsters.isEmpty || skills.isEmpty || enemySkills.isEmpty || dungeons.isEmpty || floors.isEmpty || encounterSets.isEmpty || versions.isEmpty
    }
}
