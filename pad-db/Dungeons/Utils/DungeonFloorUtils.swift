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
        
        let infoHeader = makeLabel(ofSize: 26, withText: "Floor Information")
        infoContainer.addSubview(infoHeader)
        infoHeader.topAnchor.constraint(equalTo: infoContainer.topAnchor).isActive = true
        infoHeader.centerXAnchor.constraint(equalTo: infoContainer.centerXAnchor).isActive = true
        
        let nameLabel = makeLabel(ofSize: 20, withText: dungeonFloor!.value(forKey: "name") as! String)
        infoContainer.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: infoHeader.bottomAnchor, constant: 10).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: infoContainer.centerXAnchor).isActive = true
        
        let staminaLabel = makeLabel(ofSize: 20, withText: "Stamina: " + String(dungeonFloor!.value(forKey: "stamina") as! Int))
        infoContainer.addSubview(staminaLabel)
        staminaLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10).isActive = true
        staminaLabel.centerXAnchor.constraint(equalTo: infoContainer.centerXAnchor).isActive = true
        
        let wavesLabel = makeLabel(ofSize: 20, withText: "Waves: " + String(dungeonFloor!.value(forKey: "waves") as! Int))
        infoContainer.addSubview(wavesLabel)
        wavesLabel.topAnchor.constraint(equalTo: staminaLabel.bottomAnchor, constant: 10).isActive = true
        wavesLabel.centerXAnchor.constraint(equalTo: infoContainer.centerXAnchor).isActive = true
        
        let scoreLabel = makeLabel(ofSize: 20, withText: "Score: " + String(dungeonFloor!.value(forKey: "score") as! Int))
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
        
        let infoHeader = makeLabel(ofSize: 26, withText: "Required Dungeon")
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
                let requiredLabel = makeLabel(ofSize: 18, withText: "Requires completion of")
                requiredDungeonContainer.addSubview(requiredLabel)
                requiredDungeonContainer.addSubview(requiredDungeonLabel)
                requiredDungeonContainer.addSubview(requiredFloorLabel)
                
                requiredLabel.topAnchor.constraint(equalTo: infoHeader.bottomAnchor, constant: 20).isActive = true
                requiredLabel.centerXAnchor.constraint(equalTo: requiredDungeonContainer.centerXAnchor).isActive = true
                
                requiredDungeonLabel.topAnchor.constraint(equalTo: requiredLabel.bottomAnchor, constant: 10).isActive = true
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
        
        let infoHeader = makeLabel(ofSize: 26, withText: "Messages")
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
        messageContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

    }


}
