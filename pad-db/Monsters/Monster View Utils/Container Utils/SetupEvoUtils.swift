//
//  SetupEvoUtils.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/13/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit

extension MonsterView {
    
    public func setupEvoMaterials() {
        
        let evoMaterialsLabel = makeLabel(ofSize: 20, withText: "Evolution")
        
        let separator = makeSeparator()
        
        
        let size:CGFloat = spacing * 7
        let smallSize:CGFloat = spacing * 4
        let smallerSize:CGFloat = spacing * 2
        
        let evolutions = getEvoList(forMonster: monster!)
        
        
        evoMaterialsContainer.addSubview(evoMaterialsLabel)
        evoMaterialsContainer.addSubview(separator)
        scrollView.addSubview(evoMaterialsContainer)
        
        
        evoMaterialsContainer.topAnchor.constraint(equalTo: leaderSkillContainer.bottomAnchor, constant: 20).isActive = true
        evoMaterialsContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: spacing).isActive = true
        evoMaterialsContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -spacing).isActive = true
        
        
        evoMaterialsLabel.centerXAnchor.constraint(equalTo: evoMaterialsContainer.centerXAnchor).isActive = true
        evoMaterialsLabel.topAnchor.constraint(equalTo: evoMaterialsContainer.topAnchor).isActive = true
        
        separator.bottomAnchor.constraint(equalTo: evoMaterialsContainer.bottomAnchor).isActive = true
        separator.centerXAnchor.constraint(equalTo: evoMaterialsContainer.centerXAnchor).isActive = true
        
        
        var views = [UIView]()
        
        
        if evolutions.count > 0 {
            for i in 0...evolutions.count - 1 {
                
                if evolutions[i] < 10000 {
                    let evo = evolutions[i]
                    
                    if let evoMonster = getMonster(forID: evo) {
                        
                        let view = makeView()
                        let portraitURL = getPortraitURL(id: monster!.value(forKey: "cardID") as! Int)
                        let portraitImg = makeImgView(forImg: portraitURL, ofSize: size)
                        let plusImg = makeImgView(fromIconName: "add", ofSize: smallerSize)
                        let equalsImg = makeImgView(fromIconName: "equal", ofSize: smallerSize)
                        
                        view.addSubview(portraitImg)
                        view.addSubview(plusImg)
                        
                        portraitImg.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
                        portraitImg.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                        portraitImg.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                        
                        
                        plusImg.leadingAnchor.constraint(equalTo: portraitImg.trailingAnchor, constant: spacing).isActive = true
                        plusImg.centerYAnchor.constraint(equalTo: portraitImg.centerYAnchor).isActive = true
                        
                        let evoPortraitURL = getPortraitURL(id: evoMonster.value(forKey: "cardID") as! Int)
                        let monsterImg = makeImgView(forImg: evoPortraitURL, ofSize: size)
                        monsterImg.isUserInteractionEnabled = true
                        monsterImg.addGestureRecognizer(makeTapRecognizer())
                        monsterImg.tag = evoMonster.value(forKey: "cardID") as! Int
                        
                        
                        let e1 = evoMonster.value(forKey: "evomat1") as! Int
                        let e2 = evoMonster.value(forKey: "evomat2") as! Int
                        let e3 = evoMonster.value(forKey: "evomat3") as! Int
                        let e4 = evoMonster.value(forKey: "evomat4") as! Int
                        let e5 = evoMonster.value(forKey: "evomat5") as! Int
                        
                        let evomats = [e1, e2, e3, e4, e5]
                        
                        var evoViews = [UIImageView]()
                        
                        for i in 0...evomats.count - 1 {
                            let evo = evomats[i]
                            
                            if evo != 0 {
                                let evoMaterial = getMonster(forID: evo)!
                                let img = makeImgView(forImg: getPortraitURL(id: evoMaterial.value(forKey: "cardID") as! Int), ofSize: smallSize)
                                img.tag = evoMaterial.value(forKey: "cardID") as! Int
                                img.isUserInteractionEnabled = true
                                img.addGestureRecognizer(makeTapRecognizer())
                                evoViews.append(img)
                            }
                        }
                        
                        for i in 0...evoViews.count - 1 {
                            let img = evoViews[i]
                            
                            view.addSubview(img)
                            
                            img.centerYAnchor.constraint(equalTo: portraitImg.centerYAnchor).isActive = true
                            
                            if i == 0 {
                                img.leadingAnchor.constraint(equalTo: plusImg.trailingAnchor, constant: spacing).isActive = true
                            }
                            else {
                                img.leadingAnchor.constraint(equalTo: evoViews[i-1].trailingAnchor, constant: spacing).isActive = true
                            }
                        }
                        
                        let equalsView = makeView()
                        
                        equalsView.addSubview(equalsImg)
                        equalsView.addSubview(monsterImg)
                        
                        view.addSubview(equalsView)
                        
                        
                        equalsView.leadingAnchor.constraint(equalTo: evoViews.last!.trailingAnchor, constant: spacing).isActive = true
                        equalsView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
                        equalsView.centerYAnchor.constraint(equalTo: portraitImg.centerYAnchor).isActive = true
                        
                        
                        equalsImg.leadingAnchor.constraint(equalTo: equalsView.leadingAnchor).isActive = true
                        equalsImg.centerYAnchor.constraint(equalTo: equalsView.centerYAnchor).isActive = true
                        
                        monsterImg.leadingAnchor.constraint(equalTo: equalsImg.trailingAnchor, constant: spacing).isActive = true
                        monsterImg.centerYAnchor.constraint(equalTo: equalsView.centerYAnchor).isActive = true
                        monsterImg.trailingAnchor.constraint(equalTo: equalsView.trailingAnchor).isActive = true
                        monsterImg.topAnchor.constraint(equalTo: equalsView.topAnchor).isActive = true
                        monsterImg.bottomAnchor.constraint(equalTo: equalsView.bottomAnchor).isActive = true
                        
                        views.append(view)
                    }
                }
            }
            
            if views.count > 0 {
                for i in 0...views.count - 1 {
            
                    let view = views[i]
                    evoMaterialsContainer.addSubview(view)
                    view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                    
                    if i == 0 {
                        view.topAnchor.constraint(equalTo: evoMaterialsLabel.bottomAnchor, constant: 20).isActive = true
                    }
                    else {
                        view.topAnchor.constraint(equalTo: views[i-1].bottomAnchor, constant: 10).isActive = true
                    }
                }
                views.last!.bottomAnchor.constraint(equalTo: evoMaterialsContainer.bottomAnchor, constant: -20).isActive = true
            }
        }
            
        else {
            let noneLabel = makeLabel(ofSize: 16, withText: "This monster does not evolve")
            evoMaterialsContainer.addSubview(noneLabel)
            noneLabel.centerXAnchor.constraint(equalTo: evoMaterialsLabel.centerXAnchor).isActive = true
            noneLabel.topAnchor.constraint(equalTo: evoMaterialsLabel.bottomAnchor, constant: 20).isActive = true
            noneLabel.bottomAnchor.constraint(equalTo: evoMaterialsContainer.bottomAnchor, constant: -20).isActive = true
        }
    }
    
    public func setupDevoMaterials() {
        
        let devoMaterialsLabel = makeLabel(ofSize: 20, withText: "Devolution")
        
        let separator = makeSeparator()
        
        let size:CGFloat = spacing * 7
        let smallSize:CGFloat = spacing * 4
        let smallerSize:CGFloat = spacing * 2
        
        let devolution = monster!.value(forKey: "ancestorID") as! Int
        
        
        devoMaterialsContainer.addSubview(devoMaterialsLabel)
        devoMaterialsContainer.addSubview(separator)
        scrollView.addSubview(devoMaterialsContainer)
        
        
        devoMaterialsContainer.topAnchor.constraint(equalTo: evoMaterialsContainer.bottomAnchor, constant: 20).isActive = true
        devoMaterialsContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        devoMaterialsContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        
        devoMaterialsLabel.centerXAnchor.constraint(equalTo: devoMaterialsContainer.centerXAnchor).isActive = true
        devoMaterialsLabel.topAnchor.constraint(equalTo: devoMaterialsContainer.topAnchor).isActive = true
        
        separator.bottomAnchor.constraint(equalTo: devoMaterialsContainer.bottomAnchor).isActive = true
        separator.centerXAnchor.constraint(equalTo: devoMaterialsContainer.centerXAnchor).isActive = true
        
        let isUlt = monster!.value(forKey: "isUlt") as! Bool
        
        if devolution > 0 && isUlt {
            
            if devolution != self.monster!.value(forKey: "cardID") as! Int {
                
                let view = makeView()
                let portraitImg = makeImgView(forImg: getPortraitURL(id: monster!.value(forKey: "cardID") as! Int), ofSize: size)
                
                let plusImg = makeImgView(fromIconName: "add", ofSize: smallerSize)
                let equalsImg = makeImgView(fromIconName: "equal", ofSize: smallerSize)
                
                view.addSubview(portraitImg)
                view.addSubview(plusImg)
                view.addSubview(equalsImg)
                
                portraitImg.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
                portraitImg.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                portraitImg.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                
                
                plusImg.leadingAnchor.constraint(equalTo: portraitImg.trailingAnchor, constant: spacing).isActive = true
                plusImg.centerYAnchor.constraint(equalTo: portraitImg.centerYAnchor).isActive = true
                
                
                if let d_mon = getMonster(forID: monster!.value(forKey: "ancestorID") as! Int) {
                 
                    
                    let monsterImg = makeImgView(forImg: getPortraitURL(id: d_mon.value(forKey: "cardID") as! Int), ofSize: size)
                    monsterImg.tag = d_mon.value(forKey: "cardID") as! Int
                    monsterImg.isUserInteractionEnabled = true
                    
                    monsterImg.addGestureRecognizer(makeTapRecognizer())
                    
                    view.addSubview(monsterImg)
                    monsterImg.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
                    monsterImg.centerYAnchor.constraint(equalTo: portraitImg.centerYAnchor).isActive = true
                    
                    
                    let e1 = monster!.value(forKey: "unevomat1") as! Int
                    let e2 = monster!.value(forKey: "unevomat2") as! Int
                    let e3 = monster!.value(forKey: "unevomat3") as! Int
                    let e4 = monster!.value(forKey: "unevomat4") as! Int
                    let e5 = monster!.value(forKey: "unevomat5") as! Int
                    
                    let devomats = [e1, e2, e3, e4, e5]
                    
                    var devoViews = [UIImageView]()
                    
                    for i in 0...devomats.count - 1 {
                        let devo = devomats[i]
                        let devoMaterial = getMonster(forID: devo)!
                        let img = makeImgView(forImg: getPortraitURL(id: devoMaterial.value(forKey: "cardID") as! Int), ofSize: smallSize)
                        img.tag = devoMaterial.value(forKey: "cardID") as! Int
                        img.isUserInteractionEnabled = true
                        img.addGestureRecognizer(makeTapRecognizer())
                        devoViews.append(img)
                    }
                    
                    for i in 0...devoViews.count - 1 {
                        let img = devoViews[i]
                        
                        view.addSubview(img)
                        
                        img.centerYAnchor.constraint(equalTo: portraitImg.centerYAnchor).isActive = true
                        
                        if i == 0 {
                            img.leadingAnchor.constraint(equalTo: plusImg.trailingAnchor, constant: spacing).isActive = true
                        }
                        else {
                            img.leadingAnchor.constraint(equalTo: devoViews[i-1].trailingAnchor, constant: spacing).isActive = true
                        }
                    }
                    
                    
                    equalsImg.leadingAnchor.constraint(equalTo: devoViews.last!.trailingAnchor, constant: spacing).isActive = true
                    equalsImg.centerYAnchor.constraint(equalTo: portraitImg.centerYAnchor).isActive = true
                    
                    monsterImg.leadingAnchor.constraint(equalTo: equalsImg.trailingAnchor, constant: spacing).isActive = true
                    monsterImg.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
                    monsterImg.centerYAnchor.constraint(equalTo: portraitImg.centerYAnchor).isActive = true
                    monsterImg.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
                    
                    devoMaterialsContainer.addSubview(view)
                    
                    view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                    view.bottomAnchor.constraint(equalTo: devoMaterialsContainer.bottomAnchor, constant: -10).isActive = true
                    view.topAnchor.constraint(equalTo: devoMaterialsLabel.bottomAnchor, constant: 20).isActive = true
                }
            }
        }
            
        else if devolution > 0 {
            let noneUltLabel = makeLabel(ofSize: 16, withText: "This monster cannot be devolved.")
            let prevEvoLabel = makeLabel(ofSize: 16, withText: "Ancestor is")
            let ancestorImg = makeImgView(forImg: getPortraitURL(id: getMonster(forID: devolution)!.value(forKey: "cardID") as! Int), ofSize: size)
            ancestorImg.tag = devolution
            ancestorImg.isUserInteractionEnabled = true
            ancestorImg.addGestureRecognizer(makeTapRecognizer())
            
            
            devoMaterialsContainer.addSubview(noneUltLabel)
            devoMaterialsContainer.addSubview(prevEvoLabel)
            devoMaterialsContainer.addSubview(ancestorImg)
            
            
            noneUltLabel.topAnchor.constraint(equalTo: devoMaterialsLabel.bottomAnchor, constant: 10).isActive = true
            noneUltLabel.centerXAnchor.constraint(equalTo: devoMaterialsContainer.centerXAnchor).isActive = true
            
            prevEvoLabel.topAnchor.constraint(equalTo: noneUltLabel.bottomAnchor, constant: 10).isActive = true
            prevEvoLabel.centerXAnchor.constraint(equalTo: noneUltLabel.centerXAnchor).isActive = true
            
            ancestorImg.topAnchor.constraint(equalTo: prevEvoLabel.bottomAnchor, constant: 10).isActive = true
            ancestorImg.bottomAnchor.constraint(equalTo: devoMaterialsContainer.bottomAnchor, constant: -10).isActive = true
            ancestorImg.centerXAnchor.constraint(equalTo: noneUltLabel.centerXAnchor).isActive = true
            
            
        }
            
        else {
            let noneLabel = makeLabel(ofSize: 16, withText: "This monster does not have previous evolutions")
            devoMaterialsContainer.addSubview(noneLabel)
            noneLabel.topAnchor.constraint(equalTo: devoMaterialsLabel.bottomAnchor, constant: 20).isActive = true
            noneLabel.centerXAnchor.constraint(equalTo: devoMaterialsLabel.centerXAnchor).isActive = true
            noneLabel.bottomAnchor.constraint(equalTo: devoMaterialsContainer.bottomAnchor, constant: -20).isActive = true
        }
    }
    
}
