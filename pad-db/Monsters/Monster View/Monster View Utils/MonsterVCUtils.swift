//
//  MonsterVCUtils.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/12/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension MonsterView {

    @objc
    func openMonsterPage(sender: UITapGestureRecognizer) {
        
        if let currentMonster = getMonster(forID: sender.view!.tag) {
            let monster = getMonsterFromAPI(cardID: currentMonster.cardID)!
            let monsterVC = MonsterView(monster: monster)
            monsterVC.activeSkill = getSkill(forSkill: currentMonster.activeSkillID)
            monsterVC.leaderSkill = getSkill(forSkill: currentMonster.leaderSkillID)
            
            self.navigationController?.pushViewController(monsterVC, animated: true)
        }
    }
    
    func makeTapRecognizer() -> UITapGestureRecognizer {
        let tapRec = UITapGestureRecognizer()
        tapRec.addTarget(self, action: #selector(openMonsterPage))
        return tapRec
    }
    
    @objc
    func openDungeonPage(sender: UITapGestureRecognizer) {
        let currentDungeon:Dungeon = getDungeon(forID: sender.view!.tag)!
    
        
        let floorListTable = FloorTable()
        floorListTable.dungeon_floors = getFloors(for: currentDungeon)
        floorListTable.navigationItem.title = (currentDungeon.name)
        self.navigationController?.pushViewController(floorListTable, animated: true)
    }
    
    func makeTapRecognizerDungeon() -> UITapGestureRecognizer {
        let tapRec = UITapGestureRecognizer()
        tapRec.addTarget(self, action: #selector(openDungeonPage))
        return tapRec
    }
}
