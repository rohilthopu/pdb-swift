//
//  SetupSkillUtils.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/13/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit

extension MonsterVC {
    public func setupSkills() {
        setupActiveSkill()
        setupLeaderSkill()
    }
    
    public func setupActiveSkill() {
        let activeSkillLabel = makeLabel(ofSize: 20, withText: "Active Skill")
        let separator = makeSeparator()
        activeSkillContainer.addSubview(activeSkillLabel)
        activeSkillContainer.addSubview(separator)
        scrollView.addSubview(activeSkillContainer)
        
        activeSkillContainer.topAnchor.constraint(equalTo: sawakeningContainer.bottomAnchor, constant: 20).isActive = true
        activeSkillContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        activeSkillContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        
        activeSkillLabel.topAnchor.constraint(equalTo: activeSkillContainer.topAnchor).isActive = true
        activeSkillLabel.centerXAnchor.constraint(equalTo: activeSkillContainer.centerXAnchor).isActive = true
        
        separator.bottomAnchor.constraint(equalTo: activeSkillContainer.bottomAnchor).isActive = true
        separator.centerXAnchor.constraint(equalTo: activeSkillContainer.centerXAnchor).isActive = true
        
        if let activeSkill = activeSkill {

            let minTurns = "Min: " + String(activeSkill.value(forKey: "minTurns") as! Int) + "/"
            let maxTurns = "Max: " + String(activeSkill.value(forKey: "maxTurns") as! Int)
            let turns = minTurns + maxTurns
            
            
            let nameLabel = makeLabel(ofSize: 18, withText: activeSkill.value(forKey: "name") as! String)
            let descriptionLabel = makeLabel(ofSize: 16, withText: activeSkill.value(forKey: "desc") as! String)
            let turnLabel = makeLabel(ofSize: 14, withText: turns)
            activeSkillContainer.addSubview(nameLabel)
            activeSkillContainer.addSubview(descriptionLabel)
            activeSkillContainer.addSubview(turnLabel)
            

            
            nameLabel.topAnchor.constraint(equalTo: activeSkillLabel.bottomAnchor, constant: 20).isActive = true
            nameLabel.leadingAnchor.constraint(equalTo: activeSkillContainer.leadingAnchor).isActive = true
            nameLabel.trailingAnchor.constraint(equalTo: activeSkillContainer.trailingAnchor).isActive = true
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
            descriptionLabel.leadingAnchor.constraint(equalTo: activeSkillContainer.leadingAnchor, constant: 20).isActive = true
            descriptionLabel.trailingAnchor.constraint(equalTo: activeSkillContainer.trailingAnchor, constant: -20).isActive = true
            descriptionLabel.bottomAnchor.constraint(equalTo: activeSkillContainer.bottomAnchor, constant: -20).isActive = true
            descriptionLabel.lineBreakMode = .byWordWrapping
            descriptionLabel.numberOfLines = 0
            
            turnLabel.topAnchor.constraint(equalTo: activeSkillContainer.topAnchor).isActive = true
            turnLabel.leadingAnchor.constraint(equalTo: activeSkillLabel.trailingAnchor).isActive = true
            turnLabel.trailingAnchor.constraint(equalTo: activeSkillContainer.trailingAnchor).isActive = true
            turnLabel.centerYAnchor.constraint(equalTo: activeSkillLabel.centerYAnchor).isActive = true
            turnLabel.textAlignment = .right
        }
        else {
            let noneLabel = makeLabel(ofSize: 16, withText: "No Active Skill")
            activeSkillContainer.addSubview(noneLabel)
            noneLabel.topAnchor.constraint(equalTo: activeSkillLabel.bottomAnchor, constant: 20).isActive = true
            noneLabel.bottomAnchor.constraint(equalTo: activeSkillContainer.bottomAnchor, constant: -20).isActive = true
            noneLabel.centerXAnchor.constraint(equalTo: activeSkillContainer.centerXAnchor).isActive = true
            
        }
    }
    
    public func setupLeaderSkill() {
        let leaderSkillLabel = makeLabel(ofSize: 20, withText: "Leader Skill")
        let separator = makeSeparator()
        leaderSkillContainer.addSubview(leaderSkillLabel)
        leaderSkillContainer.addSubview(separator)
        scrollView.addSubview(leaderSkillContainer)
        
        leaderSkillContainer.topAnchor.constraint(equalTo: activeSkillContainer.bottomAnchor, constant: 20).isActive = true
        leaderSkillContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        leaderSkillContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        
        leaderSkillLabel.topAnchor.constraint(equalTo: leaderSkillContainer.topAnchor).isActive = true
        leaderSkillLabel.centerXAnchor.constraint(equalTo: leaderSkillContainer.centerXAnchor).isActive = true
        
        
        separator.bottomAnchor.constraint(equalTo: leaderSkillContainer.bottomAnchor).isActive = true
        separator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        if let leaderSkill = leaderSkill {
            
            
            let multipliers = getMultipliers(leaderSkill)
            let pairMults = getPairMultipliers(multipliersSet: multipliers)
            
            
            
            let nameLabel = makeLabel(ofSize: 18, withText: leaderSkill.value(forKey: "name") as! String)
            let descriptionLabel = makeLabel(ofSize: 16, withText: leaderSkill.value(forKey: "desc") as! String)
            
            let multContainer = generateContainerForMultipliers(multipliers, pairMults)
            
            
            leaderSkillContainer.addSubview(nameLabel)
            leaderSkillContainer.addSubview(descriptionLabel)
            leaderSkillContainer.addSubview(multContainer)
            
            
            nameLabel.topAnchor.constraint(equalTo: leaderSkillLabel.bottomAnchor, constant: 20).isActive = true
            nameLabel.centerXAnchor.constraint(equalTo: leaderSkillContainer.centerXAnchor).isActive = true
            nameLabel.leadingAnchor.constraint(equalTo: leaderSkillContainer.leadingAnchor).isActive = true
            nameLabel.trailingAnchor.constraint(equalTo: leaderSkillContainer.trailingAnchor).isActive = true
            nameLabel.lineBreakMode = .byWordWrapping
            nameLabel.numberOfLines = 0

            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
            descriptionLabel.leadingAnchor.constraint(equalTo: leaderSkillContainer.leadingAnchor, constant: 20).isActive = true
            descriptionLabel.trailingAnchor.constraint(equalTo: leaderSkillContainer.trailingAnchor, constant: -20).isActive = true
            descriptionLabel.lineBreakMode = .byWordWrapping
            descriptionLabel.numberOfLines = 0
            
            
            multContainer.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
            multContainer.leadingAnchor.constraint(equalTo: leaderSkillContainer.leadingAnchor, constant: 20).isActive = true
            multContainer.trailingAnchor.constraint(equalTo: leaderSkillContainer.trailingAnchor, constant: -20).isActive = true
            multContainer.bottomAnchor.constraint(equalTo: leaderSkillContainer.bottomAnchor, constant: -20).isActive = true
            
        }
        else {
            let noneLabel = makeLabel(ofSize: 16, withText: "No Leader Skill")
            leaderSkillContainer.addSubview(noneLabel)
            
            noneLabel.topAnchor.constraint(equalTo: leaderSkillLabel.bottomAnchor, constant: 20).isActive = true
            noneLabel.centerXAnchor.constraint(equalTo: leaderSkillContainer.centerXAnchor).isActive = true
            noneLabel.bottomAnchor.constraint(equalTo: leaderSkillContainer.bottomAnchor, constant: -20).isActive = true
            
        }
    }
}
