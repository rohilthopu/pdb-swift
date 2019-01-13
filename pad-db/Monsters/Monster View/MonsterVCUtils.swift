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
    
    
    public func getMultipliers(_ skill:NSManagedObject) -> [Float] {
        var skill_list = [NSManagedObject]()
        var multipliers:[Float] = [1, 1, 1, 0, 0]
        var shield_calc:Double = 1.0
        var shields = [Double]()
        
        
        let s1 = skill.value(forKey: "cSkill1") as! Int
        let s2 = skill.value(forKey: "cSkill2") as! Int
        let s3 = skill.value(forKey: "cSkill3") as! Int

        
        if s1 != -1 {
            skill_list.append(getSkill(forSkill: s1))
            
            if s2 != -1 {
                skill_list.append(getSkill(forSkill: s2))
            }
            if s3 != -1 {
                skill_list.append(getSkill(forSkill: s3))
            }
            
            for skill in skill_list {
                multipliers[0] *= skill.value(forKey: "hpMult") as! Float
                multipliers[1] *= skill.value(forKey: "atkMult") as! Float
                multipliers[2] *= skill.value(forKey: "rcvMult") as! Float
                
                
                let shield = skill.value(forKey: "dmgReduction") as! Double
                
                if shield != 0 {
                    shields.append(shield)
                }
            }
            
            for shield in shields {
                shield_calc *= (1-shield)
            }
            
            multipliers[3] = Float(1-shield_calc)*Float(100)
            multipliers[4] = Float(1 - shield_calc)
        }
        
        else {
            multipliers[0] = skill.value(forKey: "hpMult") as! Float
            multipliers[1] = skill.value(forKey: "atkMult") as! Float
            multipliers[2] = skill.value(forKey: "rcvMult") as! Float
            multipliers[3] = (skill.value(forKey: "dmgReduction") as! Float) * 100
            multipliers[4] = skill.value(forKey: "dmgReduction") as! Float
        }
        
        return multipliers
    }
 
    public func getPairMultipliers(multipliersSet multipliers:[Float]) -> [Float] {
        
        var newMults = [Float]()
        newMults.append( Float(pow(Double(multipliers[0]), 2)))
        newMults.append( Float(pow(Double(multipliers[1]), 2)))
        newMults.append(Float(pow(Double(multipliers[2]), 2)))
        
        newMults.append((1 - (1-multipliers[4])*(1-multipliers[4]))*100)
        
        return newMults
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
    
    public func makeView() -> UIView {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.clipsToBounds = true
        return vw
    }
    
    public func generateViewsFromMultiplers(_ multipliers:[Float], _ str:String) -> UIView {
        let view = makeView()
        
        let soloLabel = makeLabel(ofSize: 16, withText: str)
        let hpLabel = makeLabel(ofSize: 16, withText: String(format: "%.2f", multipliers[0]) + "x")
        let atkLabel = makeLabel(ofSize: 16, withText: String(format: "%.2f", multipliers[1]) + "x")
        let rcvLabel = makeLabel(ofSize: 16, withText: String(format: "%.2f", multipliers[2]) + "x")
        let shieldLabel = makeLabel(ofSize: 16, withText: String(format: "%.2f", multipliers[3]) + "%")

        view.addSubview(soloLabel)
        view.addSubview(hpLabel)
        view.addSubview(atkLabel)
        view.addSubview(rcvLabel)
        view.addSubview(shieldLabel)
        
        
        soloLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        soloLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        hpLabel.topAnchor.constraint(equalTo: soloLabel.bottomAnchor, constant: 10).isActive = true
        hpLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        atkLabel.topAnchor.constraint(equalTo: hpLabel.bottomAnchor, constant: 10).isActive = true
        atkLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        rcvLabel.topAnchor.constraint(equalTo: atkLabel.bottomAnchor, constant: 10).isActive = true
        rcvLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        shieldLabel.topAnchor.constraint(equalTo: rcvLabel.bottomAnchor, constant: 10).isActive = true
        shieldLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        return view
    }
    
    public func generateContainerForMultipliaers(_ multipliers:[Float], _ pairMultipliers:[Float]) -> UIView{
        let multView = generateViewsFromMultiplers(multipliers, "Solo")
        let pairMultView = generateViewsFromMultiplers(pairMultipliers, "Pair")
        
        
        let newView = makeView()
        
        newView.addSubview(multView)
        newView.addSubview(pairMultView)
        
        multView.leadingAnchor.constraint(equalTo: newView.leadingAnchor).isActive = true
        multView.topAnchor.constraint(equalTo: newView.topAnchor).isActive = true
        multView.bottomAnchor.constraint(equalTo: newView.bottomAnchor).isActive = true
        multView.trailingAnchor.constraint(equalTo: newView.centerXAnchor).isActive = true
        
        pairMultView.topAnchor.constraint(equalTo: newView.topAnchor).isActive = true
        pairMultView.trailingAnchor.constraint(equalTo: newView.trailingAnchor).isActive = true
        pairMultView.bottomAnchor.constraint(equalTo: newView.bottomAnchor).isActive = true
        pairMultView.leadingAnchor.constraint(equalTo: newView.centerXAnchor).isActive = true
        
        return newView
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
        
        let monster = monsters.filter({
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
