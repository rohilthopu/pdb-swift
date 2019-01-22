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
    
    public func makeView() -> UIView {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.clipsToBounds = true
        return vw
    }
    
    func getSkill(forSkill id:Int) -> NSManagedObject {
        
        let skill = skills.filter({
            let currID = $0.value(forKey: "skillID") as! Int
            
            if id == currID {
                return true
            }
            else {
                return false
            }
        }).first
        
        return skill!
    }
    
    func getMonster(forID id:Int) -> NSManagedObject {
        
        let monster = goodMonsters.filter({
            let currID = $0.value(forKey: "cardID") as! Int
            
            if id == currID {
                return true
            }
            else {
                return false
            }
        }).first
                
        return monster!
    }
    
    func makeImgView(forImg link:String, ofSize size:CGFloat) -> UIImageView {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.kf.setImage(with: URL(string: link))
        
        img.widthAnchor.constraint(equalToConstant: size).isActive = true
        img.heightAnchor.constraint(equalToConstant: size).isActive = true
        
        return img
    }
    
    func makeImgView(fromIconName icon:String, ofSize size:CGFloat) -> UIImageView {
        let img = UIImageView()
        
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        
        img.image = UIImage(named: icon)
        img.heightAnchor.constraint(equalToConstant: size).isActive = true
        img.widthAnchor.constraint(equalToConstant: size).isActive = true
        
        return img
    }
    
    public func makeSeparator() -> UIView {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.clipsToBounds = true
        separator.layer.borderWidth = 1
        separator.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 3 / 4).isActive = true
        return separator
    }
    
    public func makeLabel(ofSize size: CGFloat, withText text: String) -> UILabel {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: size)
        textView.clipsToBounds = true
        textView.text = text
        return textView
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
        
        
        let navCon = UINavigationController(rootViewController: monsterVC)
        self.present(navCon, animated: true, completion: nil)
    }
    
    func makeTapRecognizer() -> UITapGestureRecognizer {
        let tapRec = UITapGestureRecognizer()
        
        tapRec.addTarget(self, action: #selector(openMonsterPage))
        
        return tapRec
    }
}
