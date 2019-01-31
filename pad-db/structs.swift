//
//  structs.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/31/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit


struct Guerrilla {
    var name:String?
    var startTime:String?
    var endTime:String?
    var startSecs:Float?
    var endSecs:Float?
    var server:String?
    var group:String?
    var dungeon_id:Int?
    var remainingTime:Double?
    var status:String?
}

struct Monster {
    var activeSkillID:Int?
    var ancestorID:Int?
    var attributeID:Int?
    var awakenings:[Int]?
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
    var evolutions:[Int]?
    var isUlt:Bool?
    var leaderSkillID:Int?
    var maxATK:Int?
    var maxHP:Int?
    var maxRCV:Int?
    var minATK:Int?
    var minHP:Int?
    var minRCV:Int?
    var maxLevel:Int?
    var maxXP:Int?
    var name:String?
    var rarity:Int?
    var subAttributeID:Int?
    var superAwakenings:[Int]?
    var type1:Int?
    var type2:Int?
    var type3:Int?
    
    var portraitLink:String?
    var fullLink:String?
    
    var sellMP:Int?
    var sellCoin:Int?
    
    var enemySkills:String?
}

struct Skill {
    var name:String?
    var description:String?
    var skillID:Int?
    var skillType:String?
    var hpMult:Float?
    var atkMult:Float?
    var rcvMult:Float?
    var dmgReduction:Double?
    var cSkill1:Int?
    var cSkill2:Int?
    var cSkill3:Int?
    var skillClass:String?
    var levels:Int?
    var minTurns:Int?
    var maxTurns:Int?
    
}
