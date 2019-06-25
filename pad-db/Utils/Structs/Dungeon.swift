//
//  Dungeon.swift
//  pad-db
//
//  Created by Rohil Thopu on 6/24/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation

struct Dungeon: Codable {
    let name: String
    let dungeonID, imageID, floorCount: Int
    let server: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case dungeonID = "dungeon_id"
        case imageID = "image_id"
        case server
        case floorCount = "floor_count"
    }
}

struct FloorListItem: Codable {
    let dungeonID, imageID, stamina, waves: Int
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case dungeonID = "dungeon_id"
        case imageID = "image_id"
        case name
        case stamina
        case waves
    }
}

struct Floor: Codable {
    let id, floorNumber: Int
    let name: String
    let stamina, waves: Int
    let possibleDrops: String
    let dungeonID, requiredDungeon, requiredFloor: Int
    let encounterModifiers, teamModifiers, entryRequirement, otherModifier: String
    let messages: String
    let score: Int
    let fixedTeam, remainingModifiers, enhancedType, enhancedAttribute: String
    let imageID: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case floorNumber = "floor_number"
        case name, stamina, waves
        case possibleDrops = "possible_drops"
        case dungeonID = "dungeon_id"
        case requiredDungeon = "required_dungeon"
        case requiredFloor = "required_floor"
        case encounterModifiers = "encounter_modifiers"
        case teamModifiers = "team_modifiers"
        case entryRequirement = "entry_requirement"
        case otherModifier = "other_modifier"
        case messages, score, fixedTeam
        case remainingModifiers = "remaining_modifiers"
        case enhancedType = "enhanced_type"
        case enhancedAttribute = "enhanced_attribute"
        case imageID = "image_id"
    }
}
