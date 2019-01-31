//
//  Utils.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/30/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import SwiftyJSON

func makeView() -> UIView {
    let vw = UIView()
    vw.translatesAutoresizingMaskIntoConstraints = false
    vw.clipsToBounds = true
    return vw
}


func makeSeparator() -> UIView {
    let separator = UIView()
    separator.translatesAutoresizingMaskIntoConstraints = false
    separator.clipsToBounds = true
    separator.layer.borderWidth = 1
    separator.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    separator.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 3 / 4).isActive = true
    return separator
}

func makeImgView(forImg link:String, ofSize size:CGFloat) -> UIImageView {
    let img = UIImageView()
    img.translatesAutoresizingMaskIntoConstraints = false
    img.clipsToBounds = true
    img.kf.setImage(with: URL(string: link))
    
    img.widthAnchor.constraint(equalToConstant: size).isActive = true
    img.heightAnchor.constraint(equalToConstant: size).isActive = true
    
    return img
}

func makeImgView(fromIconName icon:String, ofSize size:CGFloat) -> UIImageView {
    let img = UIImageView()
    
    img.translatesAutoresizingMaskIntoConstraints = false
    img.clipsToBounds = true
    
    img.image = UIImage(named: icon)
    img.heightAnchor.constraint(equalToConstant: size).isActive = true
    img.widthAnchor.constraint(equalToConstant: size).isActive = true
    
    return img
}

func makeLabel(ofSize size: CGFloat, withText text: String) -> UILabel {
    let textView = UILabel()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.font = UIFont(name: "Futura-CondensedMedium", size: size)
    textView.clipsToBounds = true
    textView.text = text
    return textView
}

func getMonster(forID id:Int) -> NSManagedObject {
    
    let monster = monsters.filter({
        let currID = $0.value(forKey: "cardID") as! Int
        
        if id == currID {
            return true
        }
        else {
            return false
        }
    }).first
    
    return monster!
}

func getMonster(forSkillID id:Int) -> NSManagedObject? {
    let monster = monsters.filter({
        let aSkill = $0.value(forKey: "activeSkillID") as! Int
        let lSkill = $0.value(forKey: "leaderSkillID") as! Int
        
        return id == aSkill || id == lSkill
        
    }).last
    return monster
}

func getSkill(forSkill id:Int) -> NSManagedObject {
    
    let skill = skills.filter({
        let currID = $0.value(forKey: "skillID") as! Int
        
        if id == currID {
            return true
        }
        else {
            return false
        }
    }).first
    
    return skill!
}

func getDungeon(forID id:Int) -> NSManagedObject? {
    return dungeons.filter{($0.value(forKey: "dungeonID") as! Int) == id}.first
}

func getFloor(forID id:Int, floorNumber num:Int) -> NSManagedObject? {
    return floors.filter{($0.value(forKey: "dungeonID") as! Int) == id && ($0.value(forKey: "floorNumber") as! Int) == num }.first
}

func getMessages(forFloor floor:NSManagedObject) -> [JSON] {
    return JSON(parseJSON: floor.value(forKey: "messages") as! String).arrayValue
}

func getPossibleDrops(forFloor floor:NSManagedObject) -> [String:JSON] {
    return JSON(parseJSON: floor.value(forKey: "possibleDrops") as! String).dictionaryValue
}

func getFixedTeam(forFloor floor:NSManagedObject) -> [String:JSON] {
    return JSON(parseJSON: floor.value(forKey: "fixedTeam") as! String).dictionaryValue
}
