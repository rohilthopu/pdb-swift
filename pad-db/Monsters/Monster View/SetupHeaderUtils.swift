//
//  SetupHeaderUtils.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/13/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit

extension MonsterVC {
    
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
    
}
