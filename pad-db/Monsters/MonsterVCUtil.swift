//
//  MonsterVCUtil.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/9/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit

extension MonsterVC {
    
    func makeBackButton() -> UIButton {
        let backButtonImage = UIImage(named: "backbutton")?.withRenderingMode(.alwaysTemplate)
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.tintColor = .blue
        backButton.setTitle("Dismiss", for: .normal)
        backButton.setTitleColor(.blue, for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
        return backButton
    }
    
    @objc
    func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    public func setupImageView() {
        
        let url = URL(string: (monster!.value(forKey: "fullURL") as! String))
        imageContainer.kf.setImage(with: url)
        
        
        scrollView.addSubview(imageContainer)
        
        imageContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        imageContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    public func setupPortraitView() {
        let url = URL(string: (monster!.value(forKey: "portraitURL") as! String))
        portraitContainer.kf.setImage(with: url)
        
        scrollView.addSubview(portraitContainer)
        portraitContainer.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 10).isActive = true
        portraitContainer.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        portraitContainer.widthAnchor.constraint(equalToConstant: 60).isActive = true
        portraitContainer.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
    }
    
    public func setupNameContainer() {
        
        let id = monster!.value(forKey: "cardID") as! Int
        IDLabel.text = "No. " + String(id)
        
        nameLabel.text = monster!.value(forKey: "name") as? String
        
        var rarity = ""
        let rare = monster!.value(forKey: "rarity") as! Int
        
        for _ in 0...rare-1 {
            rarity.append("*")
        }
        
        let cost = monster!.value(forKey: "cost") as! Int
        
        rarityLabel.text = rarity
        rarityCountLabel.text = " (" + String(rare) + ")/ Cost " + String(cost)
        
        
        containerView.addSubview(IDLabel)
        containerView.addSubview(nameLabel)
        containerView.addSubview(rarityLabel)
        containerView.addSubview(rarityCountLabel)
        
        
        scrollView.addSubview(containerView)
        
        
        // Container View that houses the extraneus items
        containerView.leadingAnchor.constraint(equalTo: portraitContainer.trailingAnchor, constant: 10).isActive = true
        containerView.topAnchor.constraint(equalTo: portraitContainer.topAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: portraitContainer.heightAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        IDLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        IDLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: IDLabel.bottomAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        
        
        rarityLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        rarityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        rarityCountLabel.leadingAnchor.constraint(equalTo: rarityLabel.trailingAnchor).isActive = true
        rarityCountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        
        
        let type1 = monster!.value(forKey: "type1") as! Int
        let type2 = monster!.value(forKey: "type2") as! Int
        let type3 = monster!.value(forKey: "type3") as! Int
        
        
        if type1 != 0 {
            let ts = [type1, type2, type3]
            
            for t in ts {
                let img = UIImageView()
                img.clipsToBounds = true
                img.translatesAutoresizingMaskIntoConstraints = false
                
                
                let img_item:String = type_base + String(t)
                img.image = UIImage(named: img_item)
                types.append(img)
            }
            
            
            for i in 0...types.count - 1 {
                
                
                let type = types[i]
                containerView.addSubview(type)
                type.widthAnchor.constraint(equalToConstant: 15).isActive = true
                type.heightAnchor.constraint(equalToConstant: 15).isActive = true
                type.centerYAnchor.constraint(equalTo: IDLabel.centerYAnchor).isActive = true
                
                if i == 0 {
                    type.leadingAnchor.constraint(equalTo: IDLabel.trailingAnchor, constant: 10).isActive = true
                }
                else {
                    type.leadingAnchor.constraint(equalTo: types[i-1].trailingAnchor, constant: 5).isActive = true
                }
            }
        }
        
        
        
        
        
        
    }
    
    public func setupStatusContainer() {
        // TODO
        setupLevelStatus()
        setupHPStatus()
        setupATKStatus()
        setupRCVStatus()
        setupXPStatus()
        setupWeightedStats()
    }
    
    public func setupLevelStatus() {
        minLevelLabel.text = "1"
        maxLevelLabel.text = String(monster!.value(forKey: "maxLevel") as! Int)
        label297.text = "+297"
        
        levelLabel.text = "lvl"
        
        
        
        levelContainer.addSubview(levelLabel)
        levelContainer.addSubview(minLevelLabel)
        levelContainer.addSubview(maxLevelLabel)
        levelContainer.addSubview(label297)
        
        scrollView.addSubview(levelContainer)
        
        
        // add constraints to the level container object first
        
        levelContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 75).isActive = true
        levelContainer.widthAnchor.constraint(equalToConstant: 50).isActive = true
        levelContainer.topAnchor.constraint(equalTo: portraitContainer.bottomAnchor, constant: 20).isActive = true
        
        // add constraints to the level items/values
        
        levelLabel.leadingAnchor.constraint(equalTo: levelContainer.leadingAnchor).isActive = true
        levelLabel.trailingAnchor.constraint(equalTo: levelContainer.trailingAnchor).isActive = true
        levelLabel.topAnchor.constraint(equalTo: levelContainer.topAnchor).isActive = true
        
        // add constraint to the min level
        
        minLevelLabel.leadingAnchor.constraint(equalTo: levelContainer.leadingAnchor).isActive = true
        minLevelLabel.trailingAnchor.constraint(equalTo: levelContainer.trailingAnchor).isActive = true
        minLevelLabel.topAnchor.constraint(equalTo: levelLabel.bottomAnchor, constant: 20).isActive = true
        
        
        // add constraint to the max level
        
        maxLevelLabel.leadingAnchor.constraint(equalTo: levelContainer.leadingAnchor).isActive = true
        maxLevelLabel.topAnchor.constraint(equalTo: minLevelLabel.bottomAnchor, constant: 20).isActive = true
        
        label297.leadingAnchor.constraint(equalTo: levelContainer.leadingAnchor).isActive = true
        label297.topAnchor.constraint(equalTo: maxLevelLabel.bottomAnchor, constant: 20).isActive = true
        label297.bottomAnchor.constraint(equalTo: levelContainer.bottomAnchor).isActive = true
    }
    
    public func setupHPStatus() {
        
        minHPLabel.text = String(monster!.value(forKey: "minHP") as! Int)
        maxHPLabel.text = String(monster!.value(forKey: "maxHP") as! Int)
        hp297.text = String((monster!.value(forKey: "maxHP") as! Int) + 990)
        
        HPLabel.text = "hp"
        
        
        HPContainer.addSubview(HPLabel)
        HPContainer.addSubview(minHPLabel)
        HPContainer.addSubview(maxHPLabel)
        HPContainer.addSubview(hp297)
        
        scrollView.addSubview(HPContainer)
        
        // add constraints to the level container object first
        
        HPContainer.leadingAnchor.constraint(equalTo: levelContainer.trailingAnchor).isActive = true
        //        HPContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        HPContainer.topAnchor.constraint(equalTo: portraitContainer.bottomAnchor, constant: 20).isActive = true
        HPContainer.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        // add constraints to the level items/values
        
        HPLabel.leadingAnchor.constraint(equalTo: HPContainer.leadingAnchor).isActive = true
        HPLabel.trailingAnchor.constraint(equalTo: HPContainer.trailingAnchor).isActive = true
        HPLabel.topAnchor.constraint(equalTo: HPContainer.topAnchor).isActive = true
        
        // add constraint to the min level
        
        minHPLabel.leadingAnchor.constraint(equalTo: HPContainer.leadingAnchor).isActive = true
        minHPLabel.trailingAnchor.constraint(equalTo: HPContainer.trailingAnchor).isActive = true
        minHPLabel.topAnchor.constraint(equalTo: HPLabel.bottomAnchor, constant: 20).isActive = true
        
        
        // add constraint to the max level
        
        maxHPLabel.leadingAnchor.constraint(equalTo: HPContainer.leadingAnchor).isActive = true
        maxHPLabel.topAnchor.constraint(equalTo: minHPLabel.bottomAnchor, constant: 20).isActive = true
        
        hp297.leadingAnchor.constraint(equalTo: HPContainer.leadingAnchor).isActive = true
        hp297.topAnchor.constraint(equalTo: maxHPLabel.bottomAnchor, constant: 20).isActive = true
        hp297.bottomAnchor.constraint(equalTo: HPContainer.bottomAnchor).isActive = true
        
    }
    
    public func setupATKStatus() {
        
        
        minATKLabel.text = String(monster!.value(forKey: "minATK") as! Int)
        maxATKLabel.text = String(monster!.value(forKey: "maxATK") as! Int)
        
        atk297.text = String((monster!.value(forKey: "maxATK") as! Int) + 495)
        ATKLabel.text = "atk"
        
        
        
        ATKContainer.addSubview(ATKLabel)
        ATKContainer.addSubview(minATKLabel)
        ATKContainer.addSubview(maxATKLabel)
        ATKContainer.addSubview(atk297)
        
        scrollView.addSubview(ATKContainer)
        
        // add constraints to the level container object first
        
        ATKContainer.leadingAnchor.constraint(equalTo: HPContainer.trailingAnchor).isActive = true
        ATKContainer.topAnchor.constraint(equalTo: portraitContainer.bottomAnchor, constant: 20).isActive = true
        ATKContainer.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        // add constraints to the level items/values
        
        ATKLabel.leadingAnchor.constraint(equalTo: ATKContainer.leadingAnchor).isActive = true
        ATKLabel.trailingAnchor.constraint(equalTo: ATKContainer.trailingAnchor).isActive = true
        ATKLabel.topAnchor.constraint(equalTo: ATKContainer.topAnchor).isActive = true
        
        // add constraint to the min level
        
        minATKLabel.leadingAnchor.constraint(equalTo: ATKContainer.leadingAnchor).isActive = true
        minATKLabel.trailingAnchor.constraint(equalTo: ATKContainer.trailingAnchor).isActive = true
        minATKLabel.topAnchor.constraint(equalTo: ATKLabel.bottomAnchor, constant: 20).isActive = true
        
        
        // add constraint to the max level
        
        maxATKLabel.leadingAnchor.constraint(equalTo: ATKContainer.leadingAnchor).isActive = true
        maxATKLabel.topAnchor.constraint(equalTo: minATKLabel.bottomAnchor, constant: 20).isActive = true
        
        atk297.leadingAnchor.constraint(equalTo: ATKContainer.leadingAnchor).isActive = true
        atk297.topAnchor.constraint(equalTo: maxATKLabel.bottomAnchor, constant: 20).isActive = true
        atk297.bottomAnchor.constraint(equalTo: ATKContainer.bottomAnchor).isActive = true
        
    }
    
    public func setupRCVStatus() {
        
        minRCVLabel.text = String(monster!.value(forKey: "minRCV") as! Int)
        maxRCVLabel.text = String(monster!.value(forKey: "maxRCV") as! Int)
        RCVLabel.text = "rcv"
        rcv297.text = String((monster!.value(forKey: "maxRCV") as! Int) + 495)
        
        RCVContainer.addSubview(RCVLabel)
        RCVContainer.addSubview(minRCVLabel)
        RCVContainer.addSubview(maxRCVLabel)
        RCVContainer.addSubview(rcv297)
        
        scrollView.addSubview(RCVContainer)
        
        // add constraints to the level container object first
        
        RCVContainer.leadingAnchor.constraint(equalTo: ATKContainer.trailingAnchor).isActive = true
        //        HPContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        RCVContainer.topAnchor.constraint(equalTo: portraitContainer.bottomAnchor, constant: 20).isActive = true
        RCVContainer.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        // add constraints to the level items/values
        
        RCVLabel.leadingAnchor.constraint(equalTo: RCVContainer.leadingAnchor).isActive = true
        RCVLabel.trailingAnchor.constraint(equalTo: RCVContainer.trailingAnchor).isActive = true
        RCVLabel.topAnchor.constraint(equalTo: RCVContainer.topAnchor).isActive = true
        
        // add constraint to the min level
        
        minRCVLabel.leadingAnchor.constraint(equalTo: RCVContainer.leadingAnchor).isActive = true
        minRCVLabel.trailingAnchor.constraint(equalTo: RCVContainer.trailingAnchor).isActive = true
        minRCVLabel.topAnchor.constraint(equalTo: RCVLabel.bottomAnchor, constant: 20).isActive = true
        
        
        // add constraint to the max level
        
        maxRCVLabel.leadingAnchor.constraint(equalTo: RCVContainer.leadingAnchor).isActive = true
        maxRCVLabel.topAnchor.constraint(equalTo: minRCVLabel.bottomAnchor, constant: 20).isActive = true
        
        
        rcv297.leadingAnchor.constraint(equalTo: RCVContainer.leadingAnchor).isActive = true
        rcv297.topAnchor.constraint(equalTo: maxRCVLabel.bottomAnchor, constant: 20).isActive = true
        rcv297.bottomAnchor.constraint(equalTo: RCVContainer.bottomAnchor).isActive = true
        
    }
    
    public func setupXPStatus() {
        
        minXPLabel.text = String(0)
        maxXPLabel.text = String(monster!.value(forKey: "maxXP") as! Int)
        XPLabel.text = "xp"
        
        
        XPContainer.addSubview(XPLabel)
        XPContainer.addSubview(minXPLabel)
        XPContainer.addSubview(maxXPLabel)
        
        scrollView.addSubview(XPContainer)
        
        // add constraints to the level container object first
        
        XPContainer.leadingAnchor.constraint(equalTo: RCVContainer.trailingAnchor).isActive = true
        XPContainer.topAnchor.constraint(equalTo: portraitContainer.bottomAnchor, constant: 20).isActive = true
        XPContainer.widthAnchor.constraint(equalTo: maxXPLabel.widthAnchor).isActive = true
        
        // add constraints to the level items/values
        
        XPLabel.leadingAnchor.constraint(equalTo: XPContainer.leadingAnchor).isActive = true
        XPLabel.trailingAnchor.constraint(equalTo: XPContainer.trailingAnchor).isActive = true
        XPLabel.topAnchor.constraint(equalTo: XPContainer.topAnchor).isActive = true
        
        // add constraint to the min level
        
        minXPLabel.leadingAnchor.constraint(equalTo: XPContainer.leadingAnchor).isActive = true
        minXPLabel.trailingAnchor.constraint(equalTo: XPContainer.trailingAnchor).isActive = true
        minXPLabel.topAnchor.constraint(equalTo: XPLabel.bottomAnchor, constant: 20).isActive = true
        
        
        // add constraint to the max level
        
        maxXPLabel.leadingAnchor.constraint(equalTo: XPContainer.leadingAnchor).isActive = true
        maxXPLabel.topAnchor.constraint(equalTo:     minXPLabel.bottomAnchor, constant: 20).isActive = true
        maxXPLabel.bottomAnchor.constraint(equalTo: XPContainer.bottomAnchor).isActive = true
        
    }
    
    public func setupWeightedStats() {
        let hp = (monster!.value(forKey: "maxHP") as! Double)/10
        let atk = (monster!.value(forKey: "maxATK") as! Double)/5
        let rcv = (monster!.value(forKey: "maxRCV") as! Double)/3
        
        let weighted = hp + atk + rcv
        
        weightedStatsLabel.text = "Weighted stats: " + String(format: "%.2f", weighted)
        
        
        scrollView.addSubview(weightedStatsLabel)
        
        weightedStatsLabel.leadingAnchor.constraint(equalTo: levelContainer.leadingAnchor).isActive = true
        weightedStatsLabel.topAnchor.constraint(equalTo: levelContainer.bottomAnchor, constant: 20).isActive = true
        
    }
    
    public func setupAwakenings() {
        
        let size = CGFloat(20)
        let size_int = 20
        
        let awks = monster!.value(forKey: "awakenings") as! [Int]
        
        
        var diff:CGFloat = 0
        
        for a in awks {
            let img = UIImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            img.clipsToBounds = true
            
            let a_img = UIImage(named: String(a + 2))
            img.image = a_img
            awakenings.append(img)
            
            awakeningContainer.addSubview(img)
        }
        
        scrollView.addSubview(awakeningContainer)
        
        let maxX = self.view.frame.width
        let a_max = awakenings.count*size_int + (awakenings.count-1)*10
        diff = (maxX - CGFloat(a_max))/2
        
        awakeningContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        awakeningContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        awakeningContainer.heightAnchor.constraint(equalToConstant: 40).isActive = true
        awakeningContainer.topAnchor.constraint(equalTo: weightedStatsLabel.bottomAnchor, constant: 20).isActive = true
        
        if awks.count > 0 {
            for i in 0...awakenings.count - 1 {
                let skill = awakenings[i]
                skill.widthAnchor.constraint(equalToConstant: size).isActive = true
                skill.heightAnchor.constraint(equalToConstant: size).isActive = true
                skill.centerYAnchor.constraint(equalTo: awakeningContainer.centerYAnchor).isActive = true
                if i == 0 {
                    skill.leadingAnchor.constraint(equalTo: awakeningContainer.leadingAnchor, constant: diff).isActive = true
                }
                else {
                    skill.leadingAnchor.constraint(equalTo: awakenings[i-1].trailingAnchor, constant: 10).isActive = true
                }
            }
        }
            
        else {
            awakeningContainer.addSubview(awokenNoneLabel)
            awokenNoneLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            awokenNoneLabel.centerYAnchor.constraint(equalTo: awakeningContainer.centerYAnchor).isActive = true
            awokenNoneLabel.trailingAnchor.constraint(lessThanOrEqualTo: awakeningContainer.trailingAnchor).isActive = true
        }
    }
    
    public func setupSuperAwakenings() {
        
        let size = CGFloat(20)
        
        let sawks = monster!.value(forKey: "superAwakenings") as! [Int]
        
        for a in sawks {
            let img = UIImageView()
            img.translatesAutoresizingMaskIntoConstraints = false
            img.clipsToBounds = true
            
            let a_img = UIImage(named: String(a + 2))
            img.image = a_img
            sawakenings.append(img)
            sawakeningContainer.addSubview(img)
        }
        
        scrollView.addSubview(sawakeningContainer)
        
        sawakeningContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        sawakeningContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        sawakeningContainer.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sawakeningContainer.topAnchor.constraint(equalTo: awakeningContainer.bottomAnchor, constant: 20).isActive = true
        
        if sawks.count > 0 {
            for i in 0...sawakenings.count - 1 {
                
                let skill = sawakenings[i]
                skill.widthAnchor.constraint(equalToConstant: size).isActive = true
                skill.heightAnchor.constraint(equalToConstant: size).isActive = true
                skill.centerYAnchor.constraint(equalTo: sawakeningContainer.centerYAnchor).isActive = true
                
                if i == 0 {
                    skill.leadingAnchor.constraint(equalTo: awakenings[0].leadingAnchor).isActive = true
                }
                else {
                    skill.leadingAnchor.constraint(equalTo: sawakenings[i-1].trailingAnchor, constant: 10).isActive = true
                }
            }
        }
            
        else {
            sawakeningContainer.addSubview(sawokenNoneLabel)
            sawokenNoneLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            sawokenNoneLabel.centerYAnchor.constraint(equalTo: sawakeningContainer.centerYAnchor).isActive = true
            sawokenNoneLabel.trailingAnchor.constraint(lessThanOrEqualTo: sawakeningContainer.trailingAnchor).isActive = true
        }
    }
    
    public func setupSkills() {
        // TODO
    }
    
    public func setupEvoMaterials() {
        
        let size:CGFloat = 40
        
        let e1 = monster!.value(forKey: "evomat1") as! Int
        let e2 = monster!.value(forKey: "evomat2") as! Int
        let e3 = monster!.value(forKey: "evomat3") as! Int
        let e4 = monster!.value(forKey: "evomat4") as! Int
        let e5 = monster!.value(forKey: "evomat5") as! Int
        
        let evomats = [e1, e2, e3, e4, e5]
        
        evoMaterialsContainer.addSubview(evoMaterialsLabel)
        
        // get the evo portrait images
        for e in evomats {
            let mat = monsters!.filter({
                let card = $0.value(forKey: "cardID") as! Int
                if e == card {
                    return true
                }
                return false
            }).first
            
            if mat != nil {
                let link = mat!.value(forKey: "portraitURL") as! String
                
                let img = UIImageView()
                img.translatesAutoresizingMaskIntoConstraints = false
                img.clipsToBounds = true
                img.kf.setImage(with: URL(string: link))
                
                evoImgs.append(img)
                evoMaterialsContainer.addSubview(img)
            }
        }
        
        scrollView.addSubview(evoMaterialsContainer)
        
        evoMaterialsContainer.topAnchor.constraint(equalTo: sawakeningContainer.bottomAnchor, constant: 20).isActive = true
        evoMaterialsContainer.leadingAnchor.constraint(equalTo: portraitContainer.leadingAnchor).isActive = true
        evoMaterialsContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        evoMaterialsContainer.heightAnchor.constraint(equalToConstant: size).isActive = true
        
        evoMaterialsLabel.leadingAnchor.constraint(equalTo: evoMaterialsContainer.leadingAnchor).isActive = true
        evoMaterialsLabel.topAnchor.constraint(equalTo: evoMaterialsContainer.topAnchor).isActive = true
        evoMaterialsLabel.centerYAnchor.constraint(equalTo: evoMaterialsContainer.centerYAnchor).isActive = true
        
        if evoImgs.count > 0 {
            for i in 0...evoImgs.count-1 {
                let img = evoImgs[i]
                img.heightAnchor.constraint(equalToConstant: 40).isActive = true
                img.widthAnchor.constraint(equalToConstant: 40).isActive = true
                img.centerYAnchor.constraint(equalTo: evoMaterialsLabel.centerYAnchor).isActive = true
                
                if i == 0 {
                    img.leadingAnchor.constraint(equalTo: evoMaterialsLabel.trailingAnchor, constant: 20).isActive = true
                }
                else {
                    img.leadingAnchor.constraint(equalTo: evoImgs[i-1].trailingAnchor, constant: 10).isActive = true
                }
            }
        }
            
        else {
            evoMaterialsLabel.removeFromSuperview()
            evoMaterialsContainer.addSubview(evoNoneLabel)
            evoNoneLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            evoNoneLabel.centerYAnchor.constraint(equalTo: evoMaterialsContainer.centerYAnchor).isActive = true
        }
    }
    
    public func setupDevoMaterials() {
        
        let size:CGFloat = 40
        
        let e1 = monster!.value(forKey: "unevomat1") as! Int
        let e2 = monster!.value(forKey: "unevomat2") as! Int
        let e3 = monster!.value(forKey: "unevomat3") as! Int
        let e4 = monster!.value(forKey: "unevomat4") as! Int
        let e5 = monster!.value(forKey: "unevomat5") as! Int
        
        let evomats = [e1, e2, e3, e4, e5]
        
        devoMaterialsContainer.addSubview(devoMaterialsLabel)
        
        // get the evo portrait images
        for e in evomats {
            let mat = monsters!.filter({
                let card = $0.value(forKey: "cardID") as! Int
                if e == card {
                    return true
                }
                return false
            }).first
            
            if mat != nil {
                let link = mat!.value(forKey: "portraitURL") as! String
                
                let img = UIImageView()
                img.translatesAutoresizingMaskIntoConstraints = false
                img.clipsToBounds = true
                img.kf.setImage(with: URL(string: link))
                
                devoImgs.append(img)
                devoMaterialsContainer.addSubview(img)
            }
        }
        
        scrollView.addSubview(devoMaterialsContainer)
        
        devoMaterialsContainer.topAnchor.constraint(equalTo: evoMaterialsContainer.bottomAnchor, constant: 20).isActive = true
        devoMaterialsContainer.leadingAnchor.constraint(equalTo: portraitContainer.leadingAnchor).isActive = true
        devoMaterialsContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        devoMaterialsContainer.heightAnchor.constraint(equalToConstant: size).isActive = true
        
        // set their constraints
        
        devoMaterialsLabel.leadingAnchor.constraint(equalTo: devoMaterialsContainer.leadingAnchor).isActive = true
        devoMaterialsLabel.topAnchor.constraint(equalTo: devoMaterialsContainer.topAnchor).isActive = true
        devoMaterialsLabel.centerYAnchor.constraint(equalTo: devoMaterialsContainer.centerYAnchor).isActive = true
        
        if devoImgs.count > 0 {
            for i in 0...devoImgs.count-1 {
                let img = devoImgs[i]
                img.heightAnchor.constraint(equalToConstant: 40).isActive = true
                img.widthAnchor.constraint(equalToConstant: 40).isActive = true
                img.centerYAnchor.constraint(equalTo: devoMaterialsLabel.centerYAnchor).isActive = true
                
                if i == 0 {
                    img.leadingAnchor.constraint(equalTo: devoMaterialsLabel.trailingAnchor, constant: 13).isActive = true
                }
                else {
                    img.leadingAnchor.constraint(equalTo: devoImgs[i-1].trailingAnchor, constant: 10).isActive = true
                }
                
            }
        }
            
        else {
            devoMaterialsLabel.removeFromSuperview()
            devoMaterialsContainer.addSubview(devoNoneLabel)
            devoNoneLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            devoNoneLabel.centerYAnchor.constraint(equalTo: devoMaterialsContainer.centerYAnchor).isActive = true
        }
    }
    
    
}
