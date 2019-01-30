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
    
    func makeBackButton() -> UIButton {
        let backButtonImage = UIImage(named: "down-arrow")
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
        return backButton
    }
    
    func makeDismissButton() -> UIButton {
        let backButtonImage = UIImage(named: "leave-all")
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.addTarget(self, action: #selector(self.dismissAll), for: .touchUpInside)
        return backButton
    }
    
    @objc
    func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc
    func dismissAll() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController?.dismiss(animated: true, completion: nil)
            (appDelegate.window?.rootViewController as? UINavigationController)?.popToRootViewController(animated: true)
        }
    }
    
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
        
        
//        let navCon = UINavigationController(rootViewController: monsterVC)
//        self.present(navCon, animated: true, completion: nil)
        self.navigationController?.pushViewController(monsterVC, animated: true)
    }
    
    func makeTapRecognizer() -> UITapGestureRecognizer {
        let tapRec = UITapGestureRecognizer()
        
        tapRec.addTarget(self, action: #selector(openMonsterPage))
        
        return tapRec
    }
}
