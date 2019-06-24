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
        return [skill.hpMult, skill.atkMult, skill.rcvMult, skill.shield]
    }
    
    public func getPairMultipliers(_ skill: Skill) -> [Double] {
        return [skill.hpMultFull, skill.atkMultFull, skill.rcvMultFull, skill.shieldFull]
    }
    
}
