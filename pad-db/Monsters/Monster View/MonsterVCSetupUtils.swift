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
        
        let nameLabel = makeLabel(ofSize: 16, withText: "")
        
        let IDLabel: UILabel = {
            let textView = UILabel()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.font = UIFont(name: "Futura-CondensedMedium", size: 20)
            textView.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            return textView
        }()
        
        let rarityLabel = makeLabel(ofSize: 20, withText: "")
        
        let rarityCountLabel = makeLabel(ofSize: 12, withText: "")
        
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
        
        
        nameContainer.addSubview(IDLabel)
        nameContainer.addSubview(nameLabel)
        nameContainer.addSubview(rarityLabel)
        nameContainer.addSubview(rarityCountLabel)
        
        
        scrollView.addSubview(nameContainer)
        
        
        // Container View that houses the extraneus items
        nameContainer.leadingAnchor.constraint(equalTo: portraitContainer.trailingAnchor, constant: 10).isActive = true
        nameContainer.topAnchor.constraint(equalTo: portraitContainer.topAnchor).isActive = true
        nameContainer.heightAnchor.constraint(equalTo: portraitContainer.heightAnchor).isActive = true
        nameContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        IDLabel.topAnchor.constraint(equalTo: nameContainer.topAnchor).isActive = true
        IDLabel.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: IDLabel.bottomAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor).isActive = true
        
        
        rarityLabel.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor).isActive = true
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
                nameContainer.addSubview(type)
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
        
        // labels for the status
        
        let levelLabel = makeLabel(ofSize: 20, withText: noString)
        let minLevelLabel = makeLabel(ofSize: 16, withText: noString)
        let maxLevelLabel = makeLabel(ofSize: 16, withText: noString)
        let label297 = makeLabel(ofSize: 16, withText: noString)
        
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
        
        // hp labels
        let HPLabel: UILabel = {
            let textView = UILabel()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.font = UIFont(name: "Futura-CondensedMedium", size: 20)
            return textView
        }()
        
        let minHPLabel: UILabel = {
            let textView = UILabel()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
            
            return textView
        }()
        
        let maxHPLabel: UILabel = {
            let textView = UILabel()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
            
            return textView
        }()
        
        let hp297: UILabel = {
            let textView = UILabel()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
            
            return textView
        }()
        
        
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
        
        
        let ATKLabel: UILabel = {
            let textView = UILabel()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.font = UIFont(name: "Futura-CondensedMedium", size: 20)
            return textView
        }()
        
        let minATKLabel: UILabel = {
            let textView = UILabel()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
            
            return textView
        }()
        
        let maxATKLabel: UILabel = {
            let textView = UILabel()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
            
            return textView
        }()
        
        let atk297: UILabel = {
            let textView = UILabel()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
            
            return textView
        }()
        
        
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
        
        
        // rcv labels
        
        let RCVLabel: UILabel = {
            let textView = UILabel()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.font = UIFont(name: "Futura-CondensedMedium", size: 20)
            return textView
        }()
        
        let minRCVLabel: UILabel = {
            let textView = UILabel()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
            
            return textView
        }()
        
        let maxRCVLabel: UILabel = {
            let textView = UILabel()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
            
            return textView
        }()
        
        let rcv297: UILabel = {
            let textView = UILabel()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
            
            return textView
        }()
        
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
        
        let XPLabel: UILabel = {
            let textView = UILabel()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.font = UIFont(name: "Futura-CondensedMedium", size: 20)
            return textView
        }()
        
        let minXPLabel: UILabel = {
            let textView = UILabel()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
            
            return textView
        }()
        
        let maxXPLabel: UILabel = {
            let textView = UILabel()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
            
            return textView
        }()
        
        
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
        
        let separator = makeSeparator()
        awakeningContainer.addSubview(separator)
        
        scrollView.addSubview(awakeningContainer)
        
        let maxX = self.view.frame.width
        let a_max = awakenings.count*size_int + (awakenings.count-1)*10
        diff = (maxX - CGFloat(a_max))/2
        
        awakeningContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        awakeningContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        awakeningContainer.heightAnchor.constraint(equalToConstant: 40).isActive = true
        awakeningContainer.topAnchor.constraint(equalTo: weightedStatsLabel.bottomAnchor, constant: 20).isActive = true
        
        separator.bottomAnchor.constraint(equalTo: awakeningContainer.bottomAnchor).isActive = true
        separator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
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
            let awokenNoneLabel: UILabel = {
                let lbl = UILabel()
                lbl.translatesAutoresizingMaskIntoConstraints = false
                lbl.clipsToBounds = true
                lbl.font = UIFont(name: "Futura-CondensedMedium", size: 16)
                lbl.text = "No Awoken Skills"
                return lbl
            }()
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
        
        let separator = makeSeparator()
        sawakeningContainer.addSubview(separator)
        scrollView.addSubview(sawakeningContainer)
        
        sawakeningContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        sawakeningContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        sawakeningContainer.heightAnchor.constraint(equalToConstant: 40).isActive = true
        sawakeningContainer.topAnchor.constraint(equalTo: awakeningContainer.bottomAnchor, constant: 20).isActive = true
        
        separator.bottomAnchor.constraint(equalTo: sawakeningContainer.bottomAnchor).isActive = true
        separator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
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
            let sawokenNoneLabel: UILabel = {
                let lbl = UILabel()
                lbl.translatesAutoresizingMaskIntoConstraints = false
                lbl.clipsToBounds = true
                lbl.font = UIFont(name: "Futura-CondensedMedium", size: 16)
                lbl.text = "No Super Awoken Skills"
                return lbl
            }()
            sawakeningContainer.addSubview(sawokenNoneLabel)
            sawokenNoneLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            sawokenNoneLabel.centerYAnchor.constraint(equalTo: sawakeningContainer.centerYAnchor).isActive = true
            sawokenNoneLabel.trailingAnchor.constraint(lessThanOrEqualTo: sawakeningContainer.trailingAnchor).isActive = true
        }
    }
    
    public func setupEvoMaterials() {
        
        let evoMaterialsLabel: UILabel = {
            let textView = UILabel()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
            textView.clipsToBounds = true
            textView.text = "Evolution"
            return textView
        }()
        
        let size:CGFloat = 50
        
        
        
        
        
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
        let separator = makeSeparator()
        evoMaterialsContainer.addSubview(separator)
        scrollView.addSubview(evoMaterialsContainer)
        
        
        evoMaterialsContainer.topAnchor.constraint(equalTo: leaderSkillContainer.bottomAnchor, constant: 20).isActive = true
        evoMaterialsContainer.leadingAnchor.constraint(equalTo: portraitContainer.leadingAnchor).isActive = true
        evoMaterialsContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        evoMaterialsContainer.heightAnchor.constraint(equalToConstant: size).isActive = true
        
        evoMaterialsLabel.leadingAnchor.constraint(equalTo: evoMaterialsContainer.leadingAnchor).isActive = true
        evoMaterialsLabel.topAnchor.constraint(equalTo: evoMaterialsContainer.topAnchor).isActive = true
        evoMaterialsLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        separator.bottomAnchor.constraint(equalTo: evoMaterialsContainer.bottomAnchor).isActive = true
        separator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
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
            let evoNoneLabel: UILabel = {
                let lbl = UILabel()
                lbl.translatesAutoresizingMaskIntoConstraints = false
                lbl.clipsToBounds = true
                lbl.font = UIFont(name: "Futura-CondensedMedium", size: 16)
                lbl.text = "No Evolution Materials"
                return lbl
            }()
            evoMaterialsLabel.removeFromSuperview()
            evoMaterialsContainer.addSubview(evoNoneLabel)
            evoNoneLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            evoNoneLabel.centerYAnchor.constraint(equalTo: evoMaterialsContainer.centerYAnchor).isActive = true
        }
    }
    
    public func setupDevoMaterials() {
        
        let devoMaterialsLabel: UILabel = {
            let textView = UILabel()
            textView.translatesAutoresizingMaskIntoConstraints = false
            textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
            textView.clipsToBounds = true
            textView.text = "Devolution Materials"
            return textView
        }()
        
        let size:CGFloat = 50
        
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
        
        let separator:UIView = makeSeparator()
        devoMaterialsContainer.addSubview(separator)
        
        scrollView.addSubview(devoMaterialsContainer)
        
        devoMaterialsContainer.topAnchor.constraint(equalTo: evoMaterialsContainer.bottomAnchor, constant: 20).isActive = true
        devoMaterialsContainer.leadingAnchor.constraint(equalTo: portraitContainer.leadingAnchor).isActive = true
        devoMaterialsContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        devoMaterialsContainer.heightAnchor.constraint(equalToConstant: size).isActive = true
        
        // set their constraints
        
        devoMaterialsLabel.leadingAnchor.constraint(equalTo: devoMaterialsContainer.leadingAnchor).isActive = true
        devoMaterialsLabel.topAnchor.constraint(equalTo: devoMaterialsContainer.topAnchor).isActive = true
        devoMaterialsLabel.centerYAnchor.constraint(equalTo: devoMaterialsContainer.centerYAnchor, constant: -5).isActive = true
        
        separator.bottomAnchor.constraint(equalTo: devoMaterialsContainer.bottomAnchor).isActive = true
        separator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
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
            
            let devoNoneLabel: UILabel = {
                let lbl = UILabel()
                lbl.translatesAutoresizingMaskIntoConstraints = false
                lbl.clipsToBounds = true
                lbl.font = UIFont(name: "Futura-CondensedMedium", size: 16)
                lbl.text = "No Devolution Materials"
                return lbl
            }()
            
            devoMaterialsLabel.removeFromSuperview()
            devoMaterialsContainer.addSubview(devoNoneLabel)
            devoNoneLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            devoNoneLabel.centerYAnchor.constraint(equalTo: devoMaterialsContainer.centerYAnchor).isActive = true
        }
    }
    
    public func setupSkills() {
        // TODO
        setupActiveSkill()
        setupLeaderSkill()
    }
    
    public func setupActiveSkill() {
        let activeSkillLabel = makeLabel(ofSize: 20, withText: "Skill:")
        let separator = makeSeparator()
        activeSkillContainer.addSubview(activeSkillLabel)
        activeSkillContainer.addSubview(separator)
        scrollView.addSubview(activeSkillContainer)
        
        activeSkillContainer.topAnchor.constraint(equalTo: sawakeningContainer.bottomAnchor, constant: 20).isActive = true
        activeSkillContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        activeSkillContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        activeSkillContainer.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        separator.bottomAnchor.constraint(equalTo: activeSkillContainer.bottomAnchor).isActive = true
        separator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        if let activeSkill = activeSkill {
            
            let minTurns = "Min: " + String(activeSkill.value(forKey: "minTurns") as! Int) + "/"
            let maxTurns = "Max: " + String(activeSkill.value(forKey: "maxTurns") as! Int)
            let turns = minTurns + maxTurns
            
            
            let nameLabel = makeLabel(ofSize: 16, withText: activeSkill.value(forKey: "name") as! String)
            let descriptionLabel = makeLabel(ofSize: 16, withText: activeSkill.value(forKey: "desc") as! String)
            let turnLabel = makeLabel(ofSize: 14, withText: turns)
            activeSkillContainer.addSubview(nameLabel)
            activeSkillContainer.addSubview(descriptionLabel)
            activeSkillContainer.addSubview(turnLabel)
            
            activeSkillLabel.topAnchor.constraint(equalTo: activeSkillContainer.topAnchor).isActive = true
            activeSkillLabel.leadingAnchor.constraint(equalTo: activeSkillContainer.leadingAnchor).isActive = true
            
            nameLabel.topAnchor.constraint(equalTo: activeSkillContainer.topAnchor).isActive = true
            nameLabel.leadingAnchor.constraint(equalTo: activeSkillLabel.trailingAnchor, constant: 10).isActive = true
            nameLabel.centerYAnchor.constraint(equalTo: activeSkillLabel.centerYAnchor).isActive = true
            
            
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20).isActive = true
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20).isActive = true
            descriptionLabel.trailingAnchor.constraint(equalTo: activeSkillContainer.trailingAnchor).isActive = true
            descriptionLabel.lineBreakMode = .byWordWrapping
            descriptionLabel.numberOfLines = 0
            
            turnLabel.trailingAnchor.constraint(equalTo: activeSkillContainer.trailingAnchor).isActive = true
            turnLabel.centerYAnchor.constraint(equalTo: activeSkillLabel.centerYAnchor).isActive = true
        }
        else {
            activeSkillLabel.removeFromSuperview()
            let noneLabel = makeLabel(ofSize: 16, withText: "No Active Skill")
            activeSkillContainer.addSubview(noneLabel)
            
            noneLabel.topAnchor.constraint(equalTo: activeSkillContainer.topAnchor).isActive = true
            noneLabel.centerYAnchor.constraint(equalTo: activeSkillContainer.centerYAnchor).isActive = true
            noneLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            
        }
    }
    
    public func setupLeaderSkill() {
        let leaderSkillLabel = makeLabel(ofSize: 20, withText: "Leader Skill:")
        let separator = makeSeparator()
        leaderSkillContainer.addSubview(leaderSkillLabel)
        leaderSkillContainer.addSubview(separator)
        scrollView.addSubview(leaderSkillContainer)
        
        leaderSkillContainer.topAnchor.constraint(equalTo: activeSkillContainer.bottomAnchor, constant: 20).isActive = true
        leaderSkillContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        leaderSkillContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        leaderSkillContainer.heightAnchor.constraint(equalToConstant: 240).isActive = true
        
        
        separator.bottomAnchor.constraint(equalTo: leaderSkillContainer.bottomAnchor).isActive = true
        separator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        if let leaderSkill = leaderSkill {
            
            
            let multipliers = getMultipliers(leaderSkill)
            let pairMults = getPairMultipliers(multipliersSet: multipliers)
            
            
            
            let nameLabel = makeLabel(ofSize: 16, withText: leaderSkill.value(forKey: "name") as! String)
            let descriptionLabel = makeLabel(ofSize: 16, withText: leaderSkill.value(forKey: "desc") as! String)
            
            let multContainer = generateContainerForMultipliaers(multipliers, pairMults)
            
            
            leaderSkillContainer.addSubview(nameLabel)
            leaderSkillContainer.addSubview(descriptionLabel)
            leaderSkillContainer.addSubview(multContainer)
            
            leaderSkillLabel.topAnchor.constraint(equalTo: leaderSkillContainer.topAnchor).isActive = true
            leaderSkillLabel.leadingAnchor.constraint(equalTo: leaderSkillContainer.leadingAnchor).isActive = true
            
            nameLabel.topAnchor.constraint(equalTo: leaderSkillContainer.topAnchor).isActive = true
            nameLabel.leadingAnchor.constraint(equalTo: leaderSkillLabel.trailingAnchor, constant: 10).isActive = true
            nameLabel.centerYAnchor.constraint(equalTo: leaderSkillLabel.centerYAnchor).isActive = true
            
            
            descriptionLabel.topAnchor.constraint(equalTo: leaderSkillLabel.bottomAnchor, constant: 20).isActive = true
            descriptionLabel.leadingAnchor.constraint(equalTo: leaderSkillContainer.leadingAnchor, constant: 10).isActive = true
            descriptionLabel.trailingAnchor.constraint(equalTo: leaderSkillContainer.trailingAnchor).isActive = true
            descriptionLabel.lineBreakMode = .byWordWrapping
            descriptionLabel.numberOfLines = 0
            
            multContainer.heightAnchor.constraint(equalToConstant: 120).isActive = true
            multContainer.widthAnchor.constraint(equalToConstant: 105).isActive = true
            multContainer.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
            multContainer.centerXAnchor.constraint(equalTo: leaderSkillContainer.centerXAnchor).isActive = true

        }
        else {
            leaderSkillLabel.removeFromSuperview()
            let noneLabel = makeLabel(ofSize: 16, withText: "No Leader Skill")
            leaderSkillContainer.addSubview(noneLabel)
            
            noneLabel.topAnchor.constraint(equalTo: leaderSkillContainer.topAnchor).isActive = true
            noneLabel.centerYAnchor.constraint(equalTo: leaderSkillContainer.centerYAnchor).isActive = true
            noneLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            
        }
    }
    
}
