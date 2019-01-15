//
//  MonsterVCUtil.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/9/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension MonsterVC {
    
    
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
            multipliers[3] = Float((skill.value(forKey: "dmgReduction") as! Double)) * 100
            multipliers[4] = Float(skill.value(forKey: "dmgReduction") as! Double)
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
    
}
