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
import SwiftyJSON

extension EncounterView {
    
    func makeInfoView() {
        
        let separator = makeSeparator()
        let header = makeLabel(ofSize: 20, withText: "Floor Information")
        makeHeader(forContainer: infoContainer, withHeader: header, withSeparator: separator)
        
        let nameLabel = makeLabel(ofSize: 16, withText: dungeonFloor!.name)
        infoContainer.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: infoContainer.centerXAnchor).isActive = true
        
        let staminaLabel = makeLabel(ofSize: 16, withText: "Stamina: " + String(dungeonFloor!.stamina))
        infoContainer.addSubview(staminaLabel)
        staminaLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        staminaLabel.centerXAnchor.constraint(equalTo: infoContainer.centerXAnchor).isActive = true
        
        let wavesLabel = makeLabel(ofSize: 16, withText: "Waves: " + String(dungeonFloor!.waves))
        infoContainer.addSubview(wavesLabel)
        wavesLabel.topAnchor.constraint(equalTo: staminaLabel.bottomAnchor, constant: 10).isActive = true
        wavesLabel.centerXAnchor.constraint(equalTo: infoContainer.centerXAnchor).isActive = true
        
        let scoreLabel = makeLabel(ofSize: 16, withText: "Score: " + String(dungeonFloor!.score))
        infoContainer.addSubview(scoreLabel)
        scoreLabel.topAnchor.constraint(equalTo: wavesLabel.bottomAnchor, constant: 10).isActive = true
        scoreLabel.centerXAnchor.constraint(equalTo: infoContainer.centerXAnchor).isActive = true
        scoreLabel.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -20).isActive = true
        
        scrollView.addSubview(infoContainer)
        
        infoContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        infoContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        infoContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        
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
                let message = messages[i]
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
        messageContainer.topAnchor.constraint(equalTo: infoContainer.bottomAnchor, constant: 20).isActive = true
        
    }
    
    func makeFixedTeam() {
        let separator = makeSeparator()
        let header = makeLabel(ofSize: 20, withText: "Fixed Team")
        makeHeader(forContainer: fixedTeamContainer, withHeader: header, withSeparator: separator)
        
        let fixedTeam = getFixedTeam(forFloor: dungeonFloor!)
        
        if !fixedTeam.isEmpty {
            var teamMonsters = [Int]()
            
            for dict in fixedTeam {
                teamMonsters.append(dict["card_id"]!.intValue)
            }
            
            let teamView = makeView()
            
            var images = [UIImageView]()
            for key in teamMonsters {
                let monsterImg = makeImgView(forImg: portrait_url + String(key) + pngEngding, ofSize: 50)
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
            teamView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20).isActive = true
            teamView.centerXAnchor.constraint(equalTo: fixedTeamContainer.centerXAnchor).isActive = true
            teamView.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -20).isActive = true
        } else {
            let noneLabel = makeLabel(ofSize: 16, withText: "No fixed team")
            fixedTeamContainer.addSubview(noneLabel)
            noneLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20).isActive = true
            noneLabel.centerXAnchor.constraint(equalTo: fixedTeamContainer.centerXAnchor).isActive = true
            noneLabel.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -20).isActive = true
        }
        
        scrollView.addSubview(fixedTeamContainer)
        fixedTeamContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        fixedTeamContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        fixedTeamContainer.topAnchor.constraint(equalTo: messageContainer.bottomAnchor, constant: 20).isActive = true
        
    }
    
    func makePossibleDrops() {
        
        let separator = makeSeparator()
        let header = makeLabel(ofSize: 20, withText: "Possible Drops")
        
        makeHeader(forContainer: possibleDropContainer, withHeader: header, withSeparator: separator)
        
        let possibleDrops = getPossibleDrops(forFloor: dungeonFloor!)
        
        var dropViews = [UIView]()
        
        if !possibleDrops.isEmpty {
            for key in possibleDrops.keys.sorted() {
                if let monster = getMonster(forID: Int(key)!) {
                    let rarity = possibleDrops[key]!.stringValue
                    
                    let dropView = makeView()
                    
                    let img = makeImgView(forImg: getPortraitURL(id: monster.cardID), ofSize: 50)
                    let nameLabel = makeLabel(ofSize: 16, withText: monster.name)
                    let rarityLabel = makeLabel(ofSize: 16, withText: rarity)
                    
                    img.isUserInteractionEnabled = true
                    img.addGestureRecognizer(makeTapRecognizer())
                    img.tag = monster.cardID
                    
                    
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
                
                } else {
                    let monster = getMonster(forID: 4014)!

                    let rarity = "Broken drop"
                    
                    let dropView = makeView()
                    
                    let img = makeImgView(forImg: getPortraitURL(id: monster.cardID), ofSize: 50)
                    let nameLabel = makeLabel(ofSize: 16, withText: monster.name)
                    let rarityLabel = makeLabel(ofSize: 16, withText: rarity)
                    
                    img.isUserInteractionEnabled = true
                    img.addGestureRecognizer(makeTapRecognizer())
                    img.tag = monster.cardID
                    
                    
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
    
//    func makeEncounters() {
//        let header = makeLabel(ofSize: 20, withText: "Possible Encounters")
//        encounterContainer.addSubview(header)
//        header.setTop(to: .top, of: encounterContainer, withSpacing: 0)
//        header.setCenterX(to: encounterContainer)
//        
//        let waveContainer = makeView()
//        var eContainers = [UIView]()
//        let encounters = getEncounters(forFloor: dungeonFloor!, wave: waveNumber!)
//        
//        if encounters.count > 0 {
//            
//            for encounter in encounters {
//                // make a container to hold each encounter item
//                let con = makeView()
//                // I can force unwrap here because I can guarantee the data existence on the server side
//                let cardID = encounter["card_id"]!.intValue
//                let portraitImage = makeImgView(forImg: getPortraitURL(id: validateCardID(forID: cardID)), ofSize: 60)
//                
//                con.addSubview(portraitImage)
//                portraitImage.setTop(to: .top, of: con, withSpacing: 0)
//                portraitImage.setLeft(to: .leading, of: con, withSpacing: 0)
//                
//                portraitImage.isUserInteractionEnabled = true
//                portraitImage.addGestureRecognizer(makeTapRecognizer())
//                portraitImage.tag = cardID
//                
//                if let monster = getMonster(forID: cardID) {
//                    let nameLabel = makeLabel(ofSize: 16, withText: monster.name)
//                    let idLabel = makeLabel(ofSize: 16, withText: "No.\(cardID)")
//                    con.addSubview(nameLabel)
//                    con.addSubview(idLabel)
//                    
//                    idLabel.setTop(to: .top, of: portraitImage, withSpacing: 0)
//                    idLabel.setLeft(to: .trailing, of: portraitImage, withSpacing: 10)
//                    
//                    idLabel.setRight(to: con, withSpacing: 0)
//                    
//                    
//                    nameLabel.setTop(to: .bottom, of: idLabel, withSpacing: 10)
//                    nameLabel.setLeft(to: .trailing, of: portraitImage, withSpacing: 10)
//                    nameLabel.setRight(to: con, withSpacing: 0)
//                    
//                    
//                    let enemySkillContainer = makeView()
//                    let eSkills = getEnemySkills(forMonster: monster)
//                    let enemySkillHeader = makeLabel(ofSize: 20, withText: "Enemy Skills")
//                    let enemySkillSeparator = makeSeparator()
//                    
//                    enemySkillContainer.addSubview(enemySkillHeader)
//                    enemySkillContainer.addSubview(enemySkillSeparator)
//                    makeHeader(forContainer: enemySkillContainer, withHeader: enemySkillHeader, withSeparator: enemySkillSeparator)
//                    
//                    if eSkills.count > 0 {
//                        // make a bunch of containers
//                        var skillViews = [UIView]()
//                        
//                        for skill in eSkills {
//                            
//                            let sView = makeView()
//                            let name = makeLabel(ofSize: 18, withText: skill.value(forKey: "name") as! String)
//                            
//                            if !name.text!.contains("ERROR") && !name.text!.contains("None") {
//                                let effect = makeLabel(ofSize: 16, withText: skill.value(forKey: "effect") as! String)
//                                
//                                sView.addSubview(name)
//                                sView.addSubview(effect)
//                                
//                                name.topAnchor.constraint(equalTo: sView.topAnchor).isActive = true
//                                name.leadingAnchor.constraint(equalTo: sView.leadingAnchor).isActive = true
//                                name.trailingAnchor.constraint(equalTo: sView.trailingAnchor).isActive = true
//                                name.adjustsFontSizeToFitWidth = true
//                                
//                                effect.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20).isActive = true
//                                effect.leadingAnchor.constraint(equalTo: sView.leadingAnchor, constant: 20).isActive = true
//                                effect.trailingAnchor.constraint(equalTo: sView.trailingAnchor).isActive = true
//                                effect.bottomAnchor.constraint(equalTo: sView.bottomAnchor).isActive = true
//                                effect.lineBreakMode = .byWordWrapping
//                                effect.numberOfLines = 0
//                                
//                                skillViews.append(sView)
//                            }
//                        }
//                        
//                        if skillViews.count == 1 {
//                            let skillView = skillViews[0]
//                            enemySkillContainer.addSubview(skillView)
//                            skillView.topAnchor.constraint(equalTo: enemySkillHeader.bottomAnchor, constant: 20).isActive = true
//                            skillView.bottomAnchor.constraint(equalTo: enemySkillSeparator.topAnchor, constant: -20).isActive = true
//                            skillView.leadingAnchor.constraint(equalTo: enemySkillContainer.leadingAnchor).isActive = true
//                            skillView.trailingAnchor.constraint(equalTo: enemySkillContainer.trailingAnchor).isActive = true
//                        } else {
//                            for i in 0...skillViews.count - 1 {
//                                let skillView = skillViews[i]
//                                enemySkillContainer.addSubview(skillView)
//                                skillView.leadingAnchor.constraint(equalTo: enemySkillContainer.leadingAnchor).isActive = true
//                                skillView.trailingAnchor.constraint(equalTo: enemySkillContainer.trailingAnchor).isActive = true
//                                
//                                if i == 0 {
//                                    skillView.topAnchor.constraint(equalTo: enemySkillHeader.bottomAnchor, constant: 20).isActive = true
//                                } else if i == skillViews.count - 1 {
//                                    skillView.topAnchor.constraint(equalTo: skillViews[i-1].bottomAnchor, constant: 20).isActive = true
//                                    skillView.bottomAnchor.constraint(equalTo: enemySkillSeparator.topAnchor, constant: -20).isActive = true
//                                } else {
//                                    skillView.topAnchor.constraint(equalTo: skillViews[i-1].bottomAnchor, constant: 20).isActive = true
//                                }
//                            }
//                        }
//                        
//                    } else {
//                        let noEnemySkillsLabel = makeLabel(ofSize: 16, withText: "No enemy skills")
//                        enemySkillContainer.addSubview(noEnemySkillsLabel)
//                        noEnemySkillsLabel.topAnchor.constraint(equalTo: enemySkillHeader.bottomAnchor, constant: 20).isActive = true
//                        noEnemySkillsLabel.centerXAnchor.constraint(equalTo: enemySkillContainer.centerXAnchor).isActive = true
//                        noEnemySkillsLabel.bottomAnchor.constraint(equalTo: enemySkillSeparator.topAnchor, constant: -20).isActive = true
//                    }
//                    
//                    con.addSubview(enemySkillContainer)
//                    enemySkillContainer.topAnchor.constraint(equalTo: portraitImage.bottomAnchor, constant: 20).isActive = true
//                    enemySkillContainer.leadingAnchor.constraint(equalTo: con.leadingAnchor, constant: 10).isActive = true
//                    enemySkillContainer.trailingAnchor.constraint(equalTo: con.trailingAnchor, constant: -10).isActive = true
//                    enemySkillContainer.bottomAnchor.constraint(equalTo: con.bottomAnchor).isActive = true
//                    
//                } else {
//                    let nameLabel = makeLabel(ofSize: 16, withText: "No data")
//                    con.addSubview(nameLabel)
//                    nameLabel.leadingAnchor.constraint(equalTo: portraitImage.trailingAnchor, constant: 10).isActive = true
//                    nameLabel.trailingAnchor.constraint(equalTo: con.trailingAnchor).isActive = true
//                    nameLabel.centerYAnchor.constraint(equalTo: portraitImage.centerYAnchor).isActive = true
//                }
//                
//                eContainers.append(con)
//            }
//        } else {
//            let noWaveDataLabel = makeLabel(ofSize: 16, withText: "No Data for Wave \(waveNumber!)")
//            let con = makeView()
//            con.addSubview(noWaveDataLabel)
//            
//            noWaveDataLabel.topAnchor.constraint(equalTo: con.topAnchor).isActive = true
//            noWaveDataLabel.centerXAnchor.constraint(equalTo: con.centerXAnchor).isActive = true
//            noWaveDataLabel.bottomAnchor.constraint(equalTo: con.bottomAnchor).isActive = true
//            eContainers.append(con)
//        }
//        
//        if eContainers.count == 1 {
//            let con = eContainers[0]
//            waveContainer.addSubview(con)
//            con.leadingAnchor.constraint(equalTo: waveContainer.leadingAnchor).isActive = true
//            con.trailingAnchor.constraint(equalTo: waveContainer.trailingAnchor).isActive = true
//            con.bottomAnchor.constraint(equalTo: waveContainer.bottomAnchor).isActive = true
//            con.topAnchor.constraint(equalTo: waveContainer.topAnchor).isActive = true
//            
//        } else {
//            
//            for i in 0...eContainers.count - 1 {
//                
//                let con = eContainers[i]
//                waveContainer.addSubview(con)
//                con.leadingAnchor.constraint(equalTo: waveContainer.leadingAnchor).isActive = true
//                con.trailingAnchor.constraint(equalTo: waveContainer.trailingAnchor).isActive = true
//                if i == 0 {
//                    con.topAnchor.constraint(equalTo: waveContainer.topAnchor).isActive = true
//                } else if i == eContainers.count - 1 {
//                    con.topAnchor.constraint(equalTo: eContainers[i-1].bottomAnchor, constant: 20).isActive = true
//                    con.bottomAnchor.constraint(equalTo: waveContainer.bottomAnchor).isActive = true
//                } else {
//                    con.topAnchor.constraint(equalTo: eContainers[i-1].bottomAnchor, constant: 10).isActive = true
//                }
//            }
//        }
//        
//        encounterContainer.addSubview(waveContainer)
//        waveContainer.leadingAnchor.constraint(equalTo: encounterContainer.leadingAnchor).isActive = true
//        waveContainer.trailingAnchor.constraint(equalTo: encounterContainer.trailingAnchor).isActive = true
//        waveContainer.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20).isActive = true
//        waveContainer.bottomAnchor.constraint(equalTo: encounterContainer.bottomAnchor).isActive = true
//        
//        scrollView.addSubview(encounterContainer)
//        encounterContainer.topAnchor.constraint(equalTo: possibleDropContainer.bottomAnchor, constant: 20).isActive = true
//        encounterContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
//        encounterContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
//        encounterContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -50).isActive = true
//    }
//    
    private func getEncounters(forFloor floor:NSManagedObject, wave waveNumber:Int) -> [[String: JSON]] {
        let results = encounterSets.filter {
            return ($0.value(forKey: "dungeonID") as! Int) == (floor.value(forKey: "dungeonID") as! Int) && ($0.value(forKey: "floorNumber") as! Int) == (floor.value(forKey: "floorNumber") as! Int) && ($0.value(forKey: "wave") as! Int) == waveNumber - 1
        }
        
        if results.count == 0 {
            return []
        } else {
            return JSON(parseJSON: results.first?.value(forKey: "encounterData") as! String).arrayValue.map {
                $0.dictionaryValue
            }
        }
    }
    
    @objc
    func openMonsterPage(sender: UITapGestureRecognizer) {
        
        if let currentMonster = getMonster(forID: sender.view!.tag) {
            let monster = getMonsterFromAPI(cardID: currentMonster.cardID)!
            let monsterVC = MonsterView(monster: monster)

            monsterVC.activeSkill = getSkill(forSkill: currentMonster.activeSkillID)
            monsterVC.leaderSkill = getSkill(forSkill: currentMonster.leaderSkillID)
            
            self.navigationController?.pushViewController(monsterVC, animated: true)
        }
    }
    
    func makeTapRecognizer() -> UITapGestureRecognizer {
        let tapRec = UITapGestureRecognizer()
        tapRec.addTarget(self, action: #selector(openMonsterPage))
        return tapRec
    }
    
    
}
