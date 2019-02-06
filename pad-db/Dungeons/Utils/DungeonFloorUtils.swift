//
//  DungeonFloorUtils.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/30/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension DungeonFloorViewController {

    func makeInfoView() {
        
        let separator = makeSeparator()
        infoContainer.addSubview(separator)
        separator.bottomAnchor.constraint(equalTo: infoContainer.bottomAnchor).isActive = true
        separator.centerXAnchor.constraint(equalTo: infoContainer.centerXAnchor).isActive = true
        
        let infoHeader = makeLabel(ofSize: 20, withText: "Floor Information")
        infoContainer.addSubview(infoHeader)
        infoHeader.topAnchor.constraint(equalTo: infoContainer.topAnchor).isActive = true
        infoHeader.centerXAnchor.constraint(equalTo: infoContainer.centerXAnchor).isActive = true
        
        let nameLabel = makeLabel(ofSize: 16, withText: dungeonFloor!.value(forKey: "name") as! String)
        infoContainer.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: infoHeader.bottomAnchor, constant: 10).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: infoContainer.centerXAnchor).isActive = true
        
        let staminaLabel = makeLabel(ofSize: 16, withText: "Stamina: " + String(dungeonFloor!.value(forKey: "stamina") as! Int))
        infoContainer.addSubview(staminaLabel)
        staminaLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        staminaLabel.centerXAnchor.constraint(equalTo: infoContainer.centerXAnchor).isActive = true
        
        let wavesLabel = makeLabel(ofSize: 16, withText: "Waves: " + String(dungeonFloor!.value(forKey: "waves") as! Int))
        infoContainer.addSubview(wavesLabel)
        wavesLabel.topAnchor.constraint(equalTo: staminaLabel.bottomAnchor, constant: 10).isActive = true
        wavesLabel.centerXAnchor.constraint(equalTo: infoContainer.centerXAnchor).isActive = true
        
        let scoreLabel = makeLabel(ofSize: 16, withText: "Score: " + String(dungeonFloor!.value(forKey: "score") as! Int))
        infoContainer.addSubview(scoreLabel)
        scoreLabel.topAnchor.constraint(equalTo: wavesLabel.bottomAnchor, constant: 10).isActive = true
        scoreLabel.centerXAnchor.constraint(equalTo: infoContainer.centerXAnchor).isActive = true
        
    
        scoreLabel.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(infoContainer)
        
        infoContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        infoContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        infoContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        
    }
    
    func makeRequiredDungeonView() {
        
        let separator = makeSeparator()
        requiredDungeonContainer.addSubview(separator)
        separator.bottomAnchor.constraint(equalTo: requiredDungeonContainer.bottomAnchor).isActive = true
        separator.centerXAnchor.constraint(equalTo: requiredDungeonContainer.centerXAnchor).isActive = true
        
        let infoHeader = makeLabel(ofSize: 20, withText: "Required Dungeon")
        requiredDungeonContainer.addSubview(infoHeader)
        infoHeader.topAnchor.constraint(equalTo: requiredDungeonContainer.topAnchor).isActive = true
        infoHeader.centerXAnchor.constraint(equalTo: requiredDungeonContainer.centerXAnchor).isActive = true
        
        
        let dungeonID = dungeonFloor!.value(forKey: "requiredDungeon") as! Int
        let floorID = dungeonFloor!.value(forKey: "requiredFloor") as! Int
        if let requiredDungeon = getDungeon(forID: dungeonID) {
            let dungeonName = requiredDungeon.value(forKey: "name") as! String
            if let floor = getFloor(forID: dungeonID, floorNumber: floorID) {
                let floorName = floor.value(forKey: "name") as! String
                let requiredDungeonLabel = makeLabel(ofSize: 16, withText: "Dungeon: \(dungeonName)")
                let requiredFloorLabel = makeLabel(ofSize: 16, withText: "Floor: \(floorName)")
                requiredDungeonContainer.addSubview(requiredDungeonLabel)
                requiredDungeonContainer.addSubview(requiredFloorLabel)
                
                requiredDungeonLabel.topAnchor.constraint(equalTo: infoHeader.bottomAnchor, constant: 10).isActive = true
                requiredDungeonLabel.centerXAnchor.constraint(equalTo: requiredDungeonContainer.centerXAnchor).isActive = true
                
                requiredFloorLabel.topAnchor.constraint(equalTo: requiredDungeonLabel.bottomAnchor, constant: 10).isActive = true
                requiredFloorLabel.centerXAnchor.constraint(equalTo: requiredDungeonContainer.centerXAnchor).isActive = true
                requiredFloorLabel.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -20).isActive = true
                
            }
        } else {
            let noneLabel = makeLabel(ofSize: 16, withText: "No required dungeon completion")
            requiredDungeonContainer.addSubview(noneLabel)
            noneLabel.topAnchor.constraint(equalTo: infoHeader.bottomAnchor, constant: 20).isActive = true
            noneLabel.centerXAnchor.constraint(equalTo: requiredDungeonContainer.centerXAnchor).isActive = true
            noneLabel.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -20).isActive = true
        }
        
        scrollView.addSubview(requiredDungeonContainer)
        
        requiredDungeonContainer.topAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: 20).isActive = true
        requiredDungeonContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        requiredDungeonContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true

    }
    
    func makeDungeonMessages() {
        let separator = makeSeparator()
        messageContainer.addSubview(separator)
        separator.bottomAnchor.constraint(equalTo: messageContainer.bottomAnchor).isActive = true
        separator.centerXAnchor.constraint(equalTo: messageContainer.centerXAnchor).isActive = true
        
        let infoHeader = makeLabel(ofSize: 20, withText: "Messages")
        messageContainer.addSubview(infoHeader)
        infoHeader.topAnchor.constraint(equalTo: messageContainer.topAnchor).isActive = true
        infoHeader.centerXAnchor.constraint(equalTo: messageContainer.centerXAnchor).isActive = true
        
        let messages = getMessages(forFloor: dungeonFloor!)
        
        var messageViews = [UILabel]()
        
        if messages.count > 0 {
            for i in 0...messages.count-1 {
                let message = messages[i].stringValue
                let messageLabel = makeLabel(ofSize: 16, withText: message)
                
                messageContainer.addSubview(messageLabel)
                messageLabel.centerXAnchor.constraint(equalTo: messageContainer.centerXAnchor).isActive = true
                
                if i == 0 {
                    messageLabel.topAnchor.constraint(equalTo: infoHeader.bottomAnchor, constant: 10).isActive = true
                } else {
                    messageLabel.topAnchor.constraint(equalTo: messageViews[i-1].bottomAnchor, constant: 10).isActive = true
                }
                messageViews.append(messageLabel)
            }
            messageViews.last?.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -20).isActive = true
        } else {
            let noneLabel = makeLabel(ofSize: 16, withText: "No messages")
            messageContainer.addSubview(noneLabel)
            noneLabel.topAnchor.constraint(equalTo: infoHeader.bottomAnchor, constant: 20).isActive = true
            noneLabel.centerXAnchor.constraint(equalTo: messageContainer.centerXAnchor).isActive = true
            noneLabel.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -20).isActive = true
        }
        
        scrollView.addSubview(messageContainer)
        messageContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        messageContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        messageContainer.topAnchor.constraint(equalTo: requiredDungeonContainer.bottomAnchor, constant: 20).isActive = true

    }
    
    func makeFixedTeam() {
        let separator = makeSeparator()
        fixedTeamContainer.addSubview(separator)
        separator.bottomAnchor.constraint(equalTo: fixedTeamContainer.bottomAnchor).isActive = true
        separator.centerXAnchor.constraint(equalTo: fixedTeamContainer.centerXAnchor).isActive = true
        
        let infoHeader = makeLabel(ofSize: 20, withText: "Fixed Team")
        fixedTeamContainer.addSubview(infoHeader)
        infoHeader.topAnchor.constraint(equalTo: fixedTeamContainer.topAnchor).isActive = true
        infoHeader.centerXAnchor.constraint(equalTo: fixedTeamContainer.centerXAnchor).isActive = true
        
        let fixedTeam = getFixedTeam(forFloor: dungeonFloor!)
        
        if !fixedTeam.isEmpty {
            let teamMonsters = fixedTeam.keys
            let teamView = makeView()
            
            var images = [UIImageView]()
            for key in teamMonsters {
                let monsterImg = makeImgView(forImg: portrait_url + key + pngEngding, ofSize: 50)
                teamView.addSubview(monsterImg)
                images.append(monsterImg)
            }
            
            
            for i in 0...images.count - 1 {
                let img = images[i]
                img.topAnchor.constraint(equalTo: teamView.topAnchor).isActive = true
                img.bottomAnchor.constraint(equalTo: teamView.bottomAnchor).isActive = true
                if i == 0 {
                    img.leadingAnchor.constraint(equalTo: teamView.leadingAnchor).isActive = true
                } else {
                    img.leadingAnchor.constraint(equalTo: images[i-1].trailingAnchor, constant: 10).isActive = true
                }
            }
            images.last?.trailingAnchor.constraint(equalTo: teamView.trailingAnchor).isActive = true
            
            fixedTeamContainer.addSubview(teamView)
            teamView.topAnchor.constraint(equalTo: infoHeader.bottomAnchor, constant: 20).isActive = true
            teamView.centerXAnchor.constraint(equalTo: fixedTeamContainer.centerXAnchor).isActive = true
            teamView.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -20).isActive = true
        } else {
            let noneLabel = makeLabel(ofSize: 16, withText: "No fixed team")
            fixedTeamContainer.addSubview(noneLabel)
            noneLabel.topAnchor.constraint(equalTo: infoHeader.bottomAnchor, constant: 20).isActive = true
            noneLabel.centerXAnchor.constraint(equalTo: fixedTeamContainer.centerXAnchor).isActive = true
            noneLabel.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -20).isActive = true
        }
        
        scrollView.addSubview(fixedTeamContainer)
        fixedTeamContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        fixedTeamContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        fixedTeamContainer.topAnchor.constraint(equalTo: messageContainer.bottomAnchor, constant: 20).isActive = true
        
    }
    
    func makePossibleDrops() {
        
        let header = makeLabel(ofSize: 20, withText: "Possible Drops")
        possibleDropContainer.addSubview(header)
        header.topAnchor.constraint(equalTo: possibleDropContainer.topAnchor).isActive = true
        header.centerXAnchor.constraint(equalTo: possibleDropContainer.centerXAnchor).isActive = true
        
        
        let separator = makeSeparator()
        possibleDropContainer.addSubview(separator)
        separator.bottomAnchor.constraint(equalTo: possibleDropContainer.bottomAnchor).isActive = true
        separator.centerXAnchor.constraint(equalTo: possibleDropContainer.centerXAnchor).isActive = true
        
        let possibleDrops = getPossibleDrops(forFloor: dungeonFloor!)

        var dropViews = [UIView]()

        if !possibleDrops.isEmpty {
            for key in possibleDrops.keys {
                let monster = getMonster(forID: Int(key)!)
                let rarity = possibleDrops[key]!.stringValue

                let dropView = makeView()

                let img = makeImgView(forImg: monster.value(forKey: "portraitURL") as! String, ofSize: 50)
                let nameLabel = makeLabel(ofSize: 16, withText: monster.value(forKey: "name") as! String)
                let rarityLabel = makeLabel(ofSize: 16, withText: rarity)
                
                img.isUserInteractionEnabled = true
                img.addGestureRecognizer(makeTapRecognizer())
                img.tag = monster.value(forKey: "cardID") as! Int


                dropView.addSubview(img)
                dropView.addSubview(nameLabel)
                dropView.addSubview(rarityLabel)

                img.leadingAnchor.constraint(equalTo: dropView.leadingAnchor).isActive = true
                img.topAnchor.constraint(equalTo: dropView.topAnchor).isActive = true
                img.bottomAnchor.constraint(equalTo: dropView.bottomAnchor).isActive = true
                

                nameLabel.leadingAnchor.constraint(equalTo: img.trailingAnchor, constant: 10).isActive = true
                nameLabel.trailingAnchor.constraint(equalTo: rarityLabel.leadingAnchor, constant: -10).isActive = true
                nameLabel.centerYAnchor.constraint(equalTo: img.centerYAnchor).isActive = true
                nameLabel.adjustsFontSizeToFitWidth = true

                rarityLabel.trailingAnchor.constraint(equalTo: dropView.trailingAnchor).isActive = true
                rarityLabel.centerYAnchor.constraint(equalTo: img.centerYAnchor).isActive = true
                rarityLabel.textAlignment = .right

                dropViews.append(dropView)
            }

            for i in 0...dropViews.count - 1 {
                let view = dropViews[i]
                possibleDropContainer.addSubview(view)
                view.leadingAnchor.constraint(equalTo: possibleDropContainer.leadingAnchor).isActive = true
                view.trailingAnchor.constraint(equalTo: possibleDropContainer.trailingAnchor).isActive = true
                view.centerXAnchor.constraint(equalTo: possibleDropContainer.centerXAnchor).isActive = true

                if i == 0 {
                    view.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20).isActive = true
                } else if i == dropViews.count - 1 {
                    view.topAnchor.constraint(equalTo: dropViews[i-1].bottomAnchor, constant: 10).isActive = true
                    view.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -20).isActive = true
                } else {
                    view.topAnchor.constraint(equalTo: dropViews[i-1].bottomAnchor, constant: 10).isActive = true
                }
            }
        } else {
            let noneLabel = makeLabel(ofSize: 16, withText: "No monster drops")
            possibleDropContainer.addSubview(noneLabel)
            noneLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20).isActive = true
            noneLabel.centerXAnchor.constraint(equalTo: possibleDropContainer.centerXAnchor).isActive = true
            noneLabel.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -20).isActive = true
        }

        scrollView.addSubview(possibleDropContainer)
        
        possibleDropContainer.topAnchor.constraint(equalTo: fixedTeamContainer.bottomAnchor, constant: 20).isActive = true
        possibleDropContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        possibleDropContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        possibleDropContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50).isActive = true
        
    }
    
    @objc
    func openMonsterPage(sender: UITapGestureRecognizer) {
        
        let currentMonster = getMonster(forID: sender.view!.tag)
        let monsterVC = MonsterVC()
        monsterVC.monster = currentMonster
        
        let activeSkill = skills.filter({
            let skillID = $0.value(forKey: "skillID") as! Int
            let aSkill = currentMonster.value(forKey: "activeSkillID") as! Int
            
            if skillID == aSkill {
                return true
            }
            else {
                return false
            }
        }).first
        
        let leaderSkill = skills.filter({
            let skillID = $0.value(forKey: "skillID") as! Int
            let lSkill = currentMonster.value(forKey: "leaderSkillID") as! Int
            
            if skillID == lSkill {
                return true
            }
            else {
                return false
            }
        }).first
        
        monsterVC.activeSkill = activeSkill
        monsterVC.leaderSkill = leaderSkill
        
        self.navigationController?.pushViewController(monsterVC, animated: true)
    }
    
    func makeTapRecognizer() -> UITapGestureRecognizer {
        let tapRec = UITapGestureRecognizer()
        tapRec.addTarget(self, action: #selector(openMonsterPage))
        return tapRec
    }


}