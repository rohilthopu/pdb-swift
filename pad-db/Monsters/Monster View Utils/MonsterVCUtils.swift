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

extension MonsterVC {

    @objc
    func openMonsterPage(sender: UITapGestureRecognizer) {
        
        let currentMonster = getMonster(forID: sender.view!.tag)
        
        let monsterVC = MonsterVC()
        monsterVC.monster = currentMonster
        
        let activeSkill = skills.filter({
            let skillID = $0.value(forKey: "skillID") as! Int
            let aSkill = currentMonster.value(forKey: "activeSkillID") as! Int
            
            if skillID == aSkill {
                return true
            }
            else {
                return false
            }
        }).first
        
        let leaderSkill = skills.filter({
            let skillID = $0.value(forKey: "skillID") as! Int
            let lSkill = currentMonster.value(forKey: "leaderSkillID") as! Int
            
            if skillID == lSkill {
                return true
            }
            else {
                return false
            }
        }).first
        
        monsterVC.activeSkill = activeSkill
        monsterVC.leaderSkill = leaderSkill
        
        self.navigationController?.pushViewController(monsterVC, animated: true)
    }
    
    func makeTapRecognizer() -> UITapGestureRecognizer {
        let tapRec = UITapGestureRecognizer()
        tapRec.addTarget(self, action: #selector(openMonsterPage))
        return tapRec
    }
    
    @objc
    func openDungeonPage(sender: UITapGestureRecognizer) {
        let currentDungeon:NSManagedObject = getDungeon(forID: sender.view!.tag)!
    
        
        let floorListTable = DungeonTableViewController()
        floorListTable.dungeon_floors = getFloors(for: currentDungeon)
        //        let titleLabel = makeLabel(ofSize: 16, withText: (currentDungeon.value(forKey: "name") as! String))
        //        floorListTable.navigationItem.titleView = titleLabel
        floorListTable.navigationItem.title = (currentDungeon.value(forKey: "name") as! String)
        self.navigationController?.pushViewController(floorListTable, animated: true)
    }
    
    func makeTapRecognizerDungeon() -> UITapGestureRecognizer {
        let tapRec = UITapGestureRecognizer()
        
        tapRec.addTarget(self, action: #selector(openDungeonPage))
        
        return tapRec
    }
}
