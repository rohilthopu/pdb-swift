//
//  Skill.swift
//  pad-db
//
//  Created by Rohil Thopu on 5/19/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation

struct Skill: Codable {
    let skillID: Int
    let name, description, skillClass, server: String
    let levels, turnMax, turnMin: Int
    let skillPart1_ID, skillPart2_ID, skillPart3_ID: Int
    let hpMult, atkMult, rcvMult, shield: Double
    
    enum CodingKeys: String, CodingKey {
        case skillID = "skill_id"
        case name
        case description = "description"
        case skillClass = "skill_class"
        case levels
        case turnMax = "turn_max"
        case turnMin = "turn_min"
        case skillPart1_ID = "skill_part_1_id"
        case skillPart2_ID = "skill_part_2_id"
        case skillPart3_ID = "skill_part_3_id"
        case hpMult = "hp_mult"
        case atkMult = "atk_mult"
        case rcvMult = "rcv_mult"
        case shield
        case server
    }
}
