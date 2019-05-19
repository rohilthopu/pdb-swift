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

extension MonsterView {
    
    public func generateViewsFromMultiplers(_ multipliers:[Double], _ str:String) -> [UILabel] {
        
        let soloLabel = makeLabel(ofSize: 16, withText: str)
        let hpLabel = makeLabel(ofSize: 16, withText: String(format: "%.2f", multipliers[0]) + "x")
        let atkLabel = makeLabel(ofSize: 16, withText: String(format: "%.2f", multipliers[1]) + "x")
        let rcvLabel = makeLabel(ofSize: 16, withText: String(format: "%.2f", multipliers[2]) + "x")
        let shieldLabel = makeLabel(ofSize: 16, withText: String(format: "%.2f", multipliers[3]) + "%")
        
        return [soloLabel, hpLabel, atkLabel, rcvLabel, shieldLabel]
        
    }
    
    public func generateContainerForMultipliers(_ multipliers:[Double], _ pairMultipliers:[Double]) -> UIView{
        let multViews:[UILabel] = generateViewsFromMultiplers(multipliers, "Solo")
        let pairMultViews:[UILabel] = generateViewsFromMultiplers(pairMultipliers, "Pair")
        
        let v = makeView()
        var vViews = [UIView]()
        
        for i in 0...multViews.count - 1 {
            
            let valViews = makeView()
            
            let label1 = multViews[i]
            let label2 = pairMultViews[i]
            
            valViews.addSubview(label1)
            valViews.addSubview(label2)

            label1.topAnchor.constraint(equalTo: valViews.topAnchor).isActive = true

            
            label2.topAnchor.constraint(equalTo: label1.bottomAnchor, constant: 20).isActive = true
            label2.bottomAnchor.constraint(equalTo: valViews.bottomAnchor).isActive = true
            label2.leadingAnchor.constraint(equalTo: valViews.leadingAnchor).isActive = true
            label2.trailingAnchor.constraint(equalTo: valViews.trailingAnchor).isActive = true
            label2.centerXAnchor.constraint(equalTo: label1.centerXAnchor).isActive = true
            
            vViews.append(valViews)
        }
        
        v.addSubview(vViews[0])
        v.addSubview(vViews[1])
        v.addSubview(vViews[2])
        v.addSubview(vViews[3])
        v.addSubview(vViews[4])
        
        
        vViews[0].leadingAnchor.constraint(equalTo: v.leadingAnchor).isActive = true
        vViews[0].topAnchor.constraint(equalTo: vViews[1].topAnchor).isActive = true
        vViews[0].bottomAnchor.constraint(equalTo: v.bottomAnchor).isActive = true
        
        
        
        let hpHead = makeLabel(ofSize: 16, withText: "hp")
        let atkHead = makeLabel(ofSize: 16, withText: "atk")
        let rcvHead = makeLabel(ofSize: 16, withText: "rcv")
        let shieldHead = makeLabel(ofSize: 16, withText: "shield")

        v.addSubview(hpHead)
        v.addSubview(atkHead)
        v.addSubview(rcvHead)
        v.addSubview(shieldHead)

        
        hpHead.topAnchor.constraint(equalTo: v.topAnchor).isActive = true
        hpHead.bottomAnchor.constraint(equalTo: vViews[1].topAnchor, constant: -20).isActive = true

        vViews[1].bottomAnchor.constraint(equalTo: v.bottomAnchor).isActive = true
        vViews[1].trailingAnchor.constraint(equalTo: vViews[2].leadingAnchor, constant: -30).isActive = true
        vViews[1].centerXAnchor.constraint(equalTo: hpHead.centerXAnchor).isActive = true
        
        atkHead.topAnchor.constraint(equalTo: v.topAnchor).isActive = true
        atkHead.bottomAnchor.constraint(equalTo: vViews[2].topAnchor, constant: -20).isActive = true
        
        vViews[2].bottomAnchor.constraint(equalTo: v.bottomAnchor).isActive = true
        vViews[2].trailingAnchor.constraint(equalTo: vViews[3].leadingAnchor, constant: -30).isActive = true
        vViews[2].centerXAnchor.constraint(equalTo: atkHead.centerXAnchor).isActive = true
        
        rcvHead.topAnchor.constraint(equalTo: v.topAnchor).isActive = true
        rcvHead.bottomAnchor.constraint(equalTo: vViews[3].topAnchor, constant: -20).isActive = true
        
        vViews[3].bottomAnchor.constraint(equalTo: v.bottomAnchor).isActive = true
        vViews[3].trailingAnchor.constraint(equalTo: vViews[4].leadingAnchor, constant: -30).isActive = true
        vViews[3].centerXAnchor.constraint(equalTo: rcvHead.centerXAnchor).isActive = true
        
        shieldHead.topAnchor.constraint(equalTo: v.topAnchor).isActive = true
        shieldHead.bottomAnchor.constraint(equalTo: vViews[4].topAnchor, constant: -20).isActive = true
        
        vViews[4].bottomAnchor.constraint(equalTo: v.bottomAnchor).isActive = true
        vViews[4].trailingAnchor.constraint(equalTo: v.trailingAnchor).isActive = true
        vViews[4].centerXAnchor.constraint(equalTo: shieldHead.centerXAnchor).isActive = true
        return v
        
    }
    
    public func getMultipliers(_ skill:Skill) -> [Double] {
        var skill_list = [Skill]()
        var multipliers:[Double] = [1.0, 1.0, 1.0, 0.0, 0.0]
        var shield_calc:Double = 1.0
        var shields = [Double]()
        
        
        let s1 = skill.skillPart1_ID
        let s2 = skill.skillPart2_ID
        let s3 = skill.skillPart3_ID
        
        
        if s1 != -1 {
            skill_list.append(getSkill(forSkill: s1))
            
            if s2 != -1 {
                skill_list.append(getSkill(forSkill: s2))
            }
            if s3 != -1 {
                skill_list.append(getSkill(forSkill: s3))
            }
            
            for skill in skill_list {
                multipliers[0] *= skill.hpMult
                multipliers[1] *= skill.atkMult
                multipliers[2] *= skill.rcvMult
                
                
                let shield = skill.shield
                
                if shield != 0 {
                    shields.append(shield)
                }
            }
            
            for shield in shields {
                shield_calc *= (1.0-shield)
            }
            
            multipliers[3] = (1.0-shield_calc)*100.0
            multipliers[4] = (1.0 - shield_calc)
        }
            
        else {
            multipliers[0] = skill.hpMult
            multipliers[1] = skill.atkMult
            multipliers[2] = skill.rcvMult
            multipliers[3] = skill.shield * 100.0
            multipliers[4] = skill.shield
        }
        
        return multipliers
    }
    
    public func getPairMultipliers(multipliersSet multipliers:[Double]) -> [Double] {
        
        var newMults = [Double]()
        newMults.append(pow(multipliers[0], 2))
        newMults.append(pow(multipliers[1], 2))
        newMults.append(pow(multipliers[2], 2))
        
        let base_val = pow((1.0-multipliers[4]), 2)
        
        newMults.append((1.0 - base_val)*100)
        
        return newMults
    }
    
}
