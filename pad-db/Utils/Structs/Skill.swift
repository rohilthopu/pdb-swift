//
//  Skill.swift
//  pad-db
//
//  Created by Rohil Thopu on 5/19/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation

struct SkillListItem: Codable {
    let skillID: Int
    let name, description, server: String
    
    enum CodingKeys: String, CodingKey {
        case skillID = "skill_id"
        case name
        case description
        case server
    }
}

struct Skill: Codable {
    let name, description: String
    let skillID: Int
    let skillType: String
    let hpMult, atkMult, rcvMult, shield: Double
    let hpMultFull, atkMultFull, rcvMultFull, shieldFull: Double
    let skillPart1_ID, skillPart2_ID, skillPart3_ID: Int
    let skillClass: String
    let levels, maxTurns, minTurns: Int
    let server: String
    
    enum CodingKeys: String, CodingKey {
        case name, shield
        case description = "description"
        case skillID = "skill_id"
        case skillType = "skill_type"
        case hpMult = "hp_mult"
        case atkMult = "atk_mult"
        case rcvMult = "rcv_mult"
        case hpMultFull = "hp_mult_full"
        case atkMultFull = "atk_mult_full"
        case rcvMultFull = "rcv_mult_full"
        case shieldFull = "shield_full"
        case skillPart1_ID = "skill_part_1_id"
        case skillPart2_ID = "skill_part_2_id"
        case skillPart3_ID = "skill_part_3_id"
        case skillClass = "skill_class"
        case levels
        case maxTurns = "max_turns"
        case minTurns = "min_turns"
        case server
    }
}
