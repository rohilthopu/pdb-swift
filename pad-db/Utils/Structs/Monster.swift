//
//  Monster.swift
//  pad-db
//
//  Created by Rohil Thopu on 5/19/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation

struct MonsterListItem: Codable {
    let cardID, collabID: Int
    let name, server: String
    let activeSkillID, leaderSkillID: Int

    
    enum CodingKeys: String, CodingKey {
        case cardID = "card_id"
        case name
        case activeSkillID = "active_skill_id"
        case leaderSkillID = "leader_skill_id"
        case server
        case collabID = "collab_id"
    }
}

struct Monster: Codable {
    let cardID: Int
    let name: String
    let attributeID, subAttributeID: Int
    let isUlt: Bool
    let type1_ID, type2_ID, type3_ID, rarity: Int
    let cost, maxLevel, feedXPAtLvl4: Int
    let releasedStatus: Bool
    let sellPriceAtLvl10, minHP, maxHP: Int
    let minAtk, maxAtk, minRcv: Int
    let maxRcv, xpMax: Int
    let xpScale, hpScale, rcvScale, atkScale: Double
    let activeSkillID, leaderSkillID, ancestorID, evoMat1: Int
    let evoMat2, evoMat3, evoMat4, evoMat5: Int
    let unEvoMat1, unEvoMat2, unEvoMat3, unEvoMat4: Int
    let unEvoMat5: Int
    let awakeningsRaw, superAwakeningsRaw: [Int]
    let awakenings, superAwakenings: [String]
    let sellMp, latentOnFeed, collabID: Int
    let isInheritable, isCollab: Bool
    let limitMult: Int
    let evolutionList: [EvolutionList]
    let server: String
    let evolutionMaterialsRaw, unEvolutionMaterialsRaw: [Int]
    let evolutionMaterials, unEvolutionMaterials, type: [String]
    let attribute, subAttribute, collab: String
    
    enum CodingKeys: String, CodingKey {
        case cardID = "card_id"
        case name
        case attributeID = "attribute_id"
        case subAttributeID = "sub_attribute_id"
        case isUlt = "is_ult"
        case type1_ID = "type_1_id"
        case type2_ID = "type_2_id"
        case type3_ID = "type_3_id"
        case rarity, cost
        case maxLevel = "max_level"
        case feedXPAtLvl4 = "feed_xp_at_lvl_4"
        case releasedStatus = "released_status"
        case sellPriceAtLvl10 = "sell_price_at_lvl_10"
        case minHP = "min_hp"
        case maxHP = "max_hp"
        case hpScale = "hp_scale"
        case minAtk = "min_atk"
        case maxAtk = "max_atk"
        case atkScale = "atk_scale"
        case minRcv = "min_rcv"
        case maxRcv = "max_rcv"
        case rcvScale = "rcv_scale"
        case xpMax = "xp_max"
        case xpScale = "xp_scale"
        case activeSkillID = "active_skill_id"
        case leaderSkillID = "leader_skill_id"
        case ancestorID = "ancestor_id"
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
        case awakeningsRaw = "awakenings_raw"
        case superAwakeningsRaw = "super_awakenings_raw"
        case awakenings
        case superAwakenings = "super_awakenings"
        case sellMp = "sell_mp"
        case latentOnFeed = "latent_on_feed"
        case collabID = "collab_id"
        case isInheritable = "is_inheritable"
        case isCollab = "is_collab"
        case limitMult = "limit_mult"
        case evolutionList = "evolution_list"
        case server
        case evolutionMaterialsRaw = "evolution_materials_raw"
        case unEvolutionMaterialsRaw = "un_evolution_materials_raw"
        case evolutionMaterials = "evolution_materials"
        case unEvolutionMaterials = "un_evolution_materials"
        case type, attribute
        case subAttribute = "sub_attribute"
        case collab
    }
}

// MARK: - EvolutionList
struct EvolutionList: Codable {
    let cardID, evoMat1, evoMat2, evoMat3: Int
    let evoMat4, evoMat5: Int
    
    enum CodingKeys: String, CodingKey {
        case cardID = "card_id"
        case evoMat1 = "evo_mat_1"
        case evoMat2 = "evo_mat_2"
        case evoMat3 = "evo_mat_3"
        case evoMat4 = "evo_mat_4"
        case evoMat5 = "evo_mat_5"
    }
}
