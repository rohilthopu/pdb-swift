//
//  setupEnemySkills.swift
//  pad-db
//
//  Created by Rohil Thopu on 2/5/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension MonsterVC {
    func setupEnemySkills() {
        let eSkills = getEnemySkills(forMonster: monster!)
        let header = makeLabel(ofSize: 20, withText: "Enemy Skills")
        let separator = makeSeparator()
        
        enemySkillContainer.addSubview(header)
        enemySkillContainer.addSubview(separator)
        
        header.topAnchor.constraint(equalTo: enemySkillContainer.topAnchor).isActive = true
        header.centerXAnchor.constraint(equalTo: enemySkillContainer.centerXAnchor).isActive = true
        
        separator.bottomAnchor.constraint(equalTo: enemySkillContainer.bottomAnchor).isActive = true
        separator.centerXAnchor.constraint(equalTo: enemySkillContainer.centerXAnchor).isActive = true
        
        if eSkills.count > 0 {
            // do something
            // TODO
        } else {
            let noneLabel = makeLabel(ofSize: 16, withText: "No enemy skills")
            enemySkillContainer.addSubview(noneLabel)
            noneLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20).isActive = true
            noneLabel.centerXAnchor.constraint(equalTo: enemySkillContainer.centerXAnchor).isActive = true
            noneLabel.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -20).isActive = true
        }
        
        scrollView.addSubview(enemySkillContainer)
        enemySkillContainer.topAnchor.constraint(equalTo: leaderSkillContainer.bottomAnchor, constant: 20).isActive = true
        enemySkillContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        enemySkillContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        
        
    }
}
