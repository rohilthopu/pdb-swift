//
//  Monster.swift
//  pad-db
//
//  Created by Rohil Thopu on 5/19/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation

struct MonsterListItem: Codable {
    let cardID: Int
    let name, server: String
    let activeSkillID, leaderSkillID: Int

    
    enum CodingKeys: String, CodingKey {
        case cardID = "card_id"
        case name
        case activeSkillID = "active_skill_id"
        case leaderSkillID = "leader_skill_id"
        case server
    }
}

struct Monster: Codable {
    let id, activeSkillID, ancestorID, attributeID: Int
    let attribute, awakenings, awakeningsRaw: String
    let cardID, cost: Int
    let inheritable, isCollab, isReleased, isUlt: Bool
    let leaderSkillID, maxAtk, maxHP, maxLevel: Int
    let maxRcv, minAtk, minHP, minRcv: Int
    let maxXP: Int
    let name: String
    let rarity, subAttributeID: Int
    let subAttribute, superAwakenings, evolutions: String
    let evoMat1, evoMat2, evoMat3, evoMat4: Int
    let evoMat5, unEvoMat1, unEvoMat2, unEvoMat3: Int
    let unEvoMat4, unEvoMat5, type1, type2: Int
    let type3, sellMp, sellCoin: Int
    let enemySkills, server: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case activeSkillID = "active_skill_id"
        case ancestorID = "ancestor_id"
        case attributeID = "attribute_id"
        case attribute, awakenings
        case awakeningsRaw = "awakenings_raw"
        case cardID = "card_id"
        case cost, inheritable
        case isCollab = "is_collab"
        case isReleased = "is_released"
        case isUlt = "is_ult"
        case leaderSkillID = "leader_skill_id"
        case maxAtk = "max_atk"
        case maxHP = "max_hp"
        case maxLevel = "max_level"
        case maxRcv = "max_rcv"
        case minAtk = "min_atk"
        case minHP = "min_hp"
        case minRcv = "min_rcv"
        case maxXP = "max_xp"
        case name, rarity
        case subAttributeID = "sub_attribute_id"
        case subAttribute = "sub_attribute"
        case superAwakenings = "super_awakenings"
        case evolutions
        case evoMat1 = "evo_mat_1"
        case evoMat2 = "evo_mat_2"
        case evoMat3 = "evo_mat_3"
        case evoMat4 = "evo_mat_4"
        case evoMat5 = "evo_mat_5"
        case unEvoMat1 = "un_evo_mat_1"
        case unEvoMat2 = "un_evo_mat_2"
        case unEvoMat3 = "un_evo_mat_3"
        case unEvoMat4 = "un_evo_mat_4"
        case unEvoMat5 = "un_evo_mat_5"
        case type1 = "type_1"
        case type2 = "type_2"
        case type3 = "type_3"
        case sellMp = "sell_mp"
        case sellCoin = "sell_coin"
        case enemySkills = "enemy_skills"
        case server
    }
}
