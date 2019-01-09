//
//  Monster.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/8/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation


class Monster {
    var activeSkillID:Int?
    var ancestorID:Int?
    var attrID:Int?
    var cardID:Int?
    var cost:Int?
    var unevomat1:Int?
    var unevomat2:Int?
    var unevomat3:Int?
    var unevomat4:Int?
    var unevomat5:Int?
    var evomat1:Int?
    var evomat2:Int?
    var evomat3:Int?
    var evomat4:Int?
    var evomat5:Int?
    var maxATK:Int?
    var maxHP:Int?
    var maxRCV:Int?
    var minATK:Int?
    var minHP:Int?
    var minRCV:Int?
    var name:String?
    var rarity:Int?
    var subAttrID:Int?
    var type1:Int?
    var type2:Int?
    var type3:Int?
    
    
    
    init(card:Dictionary<String, Any>) {
        self.activeSkillID = card["activeSkillID"].intValue
        self.ancestorID = card["ancestorID"].intValue
        self.attrID = card["attributeID"].intValue
        self.cardID = card["cardID"].intValue
        self.cost = card["cost"].intValue
        self.unevomat1 = card["unevomat1"].intValue
        self.unevomat2 = card["unevomat2"].intValue
        self.unevomat3 = card["unevomat3"].intValue
        self.unevomat4 = card["unevomat4"].intValue
        self.unevomat5 = card["unevomat5"].intValue
        self.evomat1 = card["evomat1"].intValue
        self.evomat2 = card["evomat2"].intValue
        self.evomat3 = card["evomat3"].intValue
        self.evomat4 = card["evomat4"].intValue
        self.evomat5 = card["evomat5"].intValue
        self.maxATK = card["maxATK"].intValue
        self.maxHP = card["maxHP"].intValue
        self.maxRCV = card["maxRCV"].intValue
        self.minATK = card["minATK"].intValue
        self.minHP = card["minHP"].intValue
        self.minRCV = card["minRCV"].intValue
        self.name = card["name"].stringValue
        self.rarity = card["rarity"].intValue
        self.subAttrID = card["subAttributeID"].intValue
    }
}
