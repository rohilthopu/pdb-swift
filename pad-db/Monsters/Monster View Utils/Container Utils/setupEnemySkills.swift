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
            // make a bunch of containers
            
            var skillViews = [UIView]()
            
            for skill in eSkills {
                
                let sView = makeView()
                let name = makeLabel(ofSize: 16, withText: skill.value(forKey: "name") as! String)
                
                if !name.text!.contains("ERROR") && !name.text!.contains("None") {
                    let effect = makeLabel(ofSize: 14, withText: skill.value(forKey: "effect") as! String)
                    
                    sView.addSubview(name)
                    sView.addSubview(effect)
                    
                    name.topAnchor.constraint(equalTo: sView.topAnchor).isActive = true
                    name.leadingAnchor.constraint(equalTo: sView.leadingAnchor).isActive = true
                    name.trailingAnchor.constraint(equalTo: sView.trailingAnchor).isActive = true
                    name.adjustsFontSizeToFitWidth = true
                    
                    effect.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20).isActive = true
                    effect.leadingAnchor.constraint(equalTo: sView.leadingAnchor, constant: 20).isActive = true
                    effect.trailingAnchor.constraint(equalTo: sView.trailingAnchor).isActive = true
                    effect.bottomAnchor.constraint(equalTo: sView.bottomAnchor).isActive = true
                    effect.lineBreakMode = .byWordWrapping
                    effect.numberOfLines = 0
                    
                    skillViews.append(sView)
                }
            }
            
            for i in 0...skillViews.count - 1 {
                let sView = skillViews[i]
                enemySkillContainer.addSubview(sView)
                sView.leadingAnchor.constraint(equalTo: enemySkillContainer.leadingAnchor).isActive = true
                sView.trailingAnchor.constraint(equalTo: enemySkillContainer.trailingAnchor).isActive = true
                
                if i == 0 && skillViews.count == 1 {
                    sView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20).isActive = true
                    sView.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -20).isActive = true
                } else if i == 0 {
                    sView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20).isActive = true
                } else if i == skillViews.count - 1 {
                    sView.topAnchor.constraint(equalTo: skillViews[i-1].bottomAnchor, constant: 20).isActive = true
                    sView.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -20).isActive = true
                } else {
                    sView.topAnchor.constraint(equalTo: skillViews[i-1].bottomAnchor, constant: 20).isActive = true
                }
            }
            
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
