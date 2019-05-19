//
//  Monster.swift
//  pad-db
//
//  Created by Rohil Thopu on 5/19/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation

struct Monster: Codable {
    let cardID: Int
    let name, server: String
    let attrID, subAttrID: Int
    let isUlt: Bool
    let type1_ID, type2_ID, rarity, cost: Int
    let maxLevel, feedXPAtLvl4: Int
    let releasedStatus: Bool
    let sellPriceAtLvl10, minHP, maxHP: Int
    let minAtk, maxAtk, minRcv: Int
    let maxRcv, xpMax: Int
    let xpScale, atkScale, rcvScale, hpScale, enemyAtkScale, enemyDefScale, enemyHPScale: Double
    let activeSkillID, leaderSkillID, enemyTurns, enemyHPMin: Int
    let enemyHPMax, enemyAtkMin, enemyAtkMax: Int
    let enemyDefMin, enemyDefMax: Int
    let enemyMaxLevel, enemyCoinsAtLvl2, enemyXPAtLvl2, ancestorID: Int
    let evoMatID1, evoMatID2, evoMatID3, evoMatID4: Int
    let evoMatID5, unEvoMat1, unEvoMat2, unEvoMat3: Int
    let unEvoMat4, unEvoMat5, enemyTurnsAlt, enemySkillEffect: Int
    let enemySkillRefs, awakenings, superAwakenings, evoList: [Int]
    let baseID, type3_ID, sellMp, latentOnFeed: Int
    let collabID: Int
    let inheritable, isCollab: Bool
    let limitMult, voiceID: Int
    
    enum CodingKeys: String, CodingKey {
        case cardID = "card_id"
        case name
        case attrID = "attr_id"
        case subAttrID = "sub_attr_id"
        case isUlt = "is_ult"
        case type1_ID = "type_1_id"
        case type2_ID = "type_2_id"
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
        case enemyTurns = "enemy_turns"
        case enemyHPMin = "enemy_hp_min"
        case enemyHPMax = "enemy_hp_max"
        case enemyHPScale = "enemy_hp_scale"
        case enemyAtkMin = "enemy_atk_min"
        case enemyAtkMax = "enemy_atk_max"
        case enemyAtkScale = "enemy_atk_scale"
        case enemyDefMin = "enemy_def_min"
        case enemyDefMax = "enemy_def_max"
        case enemyDefScale = "enemy_def_scale"
        case enemyMaxLevel = "enemy_max_level"
        case enemyCoinsAtLvl2 = "enemy_coins_at_lvl_2"
        case enemyXPAtLvl2 = "enemy_xp_at_lvl_2"
        case ancestorID = "ancestor_id"
        case evoMatID1 = "evo_mat_id_1"
        case evoMatID2 = "evo_mat_id_2"
        case evoMatID3 = "evo_mat_id_3"
        case evoMatID4 = "evo_mat_id_4"
        case evoMatID5 = "evo_mat_id_5"
        case unEvoMat1 = "un_evo_mat_1"
        case unEvoMat2 = "un_evo_mat_2"
        case unEvoMat3 = "un_evo_mat_3"
        case unEvoMat4 = "un_evo_mat_4"
        case unEvoMat5 = "un_evo_mat_5"
        case enemyTurnsAlt = "enemy_turns_alt"
        case enemySkillEffect = "enemy_skill_effect"
        case enemySkillRefs = "enemy_skill_refs"
        case awakenings
        case superAwakenings = "super_awakenings"
        case baseID = "base_id"
        case type3_ID = "type_3_id"
        case sellMp = "sell_mp"
        case latentOnFeed = "latent_on_feed"
        case collabID = "collab_id"
        case inheritable
        case isCollab = "is_collab"
        case limitMult = "limit_mult"
        case voiceID = "voice_id"
        case evoList = "evo_list"
        case server
    }
}
