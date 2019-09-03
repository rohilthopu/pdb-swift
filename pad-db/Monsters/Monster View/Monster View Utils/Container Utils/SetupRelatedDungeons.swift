//
//  SetupRelatedDungeons.swift
//  pad-db
//
//  Created by Rohil Thopu on 2/4/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension MonsterView {
    func setupRelatedDungeons() {
        let relatedDungeons = [Int]()
        
        let header = makeLabel(ofSize: 20, withText: "Related Dungeons")
        relatedDungeonContainer.addSubview(header)
        header.topAnchor.constraint(equalTo: relatedDungeonContainer.topAnchor).isActive = true
        header.centerXAnchor.constraint(equalTo: relatedDungeonContainer.centerXAnchor).isActive = true
        
        let separator = makeSeparator()
        relatedDungeonContainer.addSubview(separator)
        separator.bottomAnchor.constraint(equalTo: relatedDungeonContainer.bottomAnchor).isActive = true
        separator.centerXAnchor.constraint(equalTo: relatedDungeonContainer.centerXAnchor).isActive = true
        
        if !relatedDungeons.isEmpty {
            var allViews = [UILabel?]()
            for dungeon in relatedDungeons {
                let label = makeLabel(ofSize: 14, withText: String(dungeon))
                label.adjustsFontSizeToFitWidth = true
                label.textAlignment = .center
                label.isUserInteractionEnabled = true
                label.addGestureRecognizer(makeTapRecognizerDungeon())
                label.tag = dungeon
                label.layer.borderWidth = 0.25
                label.layer.cornerRadius = 3
                allViews.append(label)
            }
            
            var pairs = stride(from: 0, to: allViews.count, by: 2).map{ind -> (UILabel?, UILabel?) in
                let first = allViews[ind]
                let second = ind+1 < allViews.count ? allViews[ind+1] : nil
                return (first, second)
            }
            
            let pairContainer = makeView()
            
            
            for i in 0..<pairs.count {
                
                let pair = pairs[i]
                // make a view container for each pair
                let pView = makeView()
                
                pairContainer.addSubview(pView)
                pView.leadingAnchor.constraint(equalTo: pairContainer.leadingAnchor).isActive = true
                pView.trailingAnchor.constraint(equalTo: pairContainer.trailingAnchor).isActive = true
            
                // first one will always exist if this runs, so can force unwrap
                let v1 = pair.0!
                
                pView.addSubview(v1)
                
                v1.leadingAnchor.constraint(equalTo: pView.leadingAnchor).isActive = true
                v1.trailingAnchor.constraint(equalTo: pView.centerXAnchor, constant: -5).isActive = true
                v1.topAnchor.constraint(equalTo: pView.topAnchor).isActive = true
                v1.bottomAnchor.constraint(equalTo: pView.bottomAnchor).isActive = true
                
                
                // not guaranteed to exist, so need to check for optionals
                if let v2 = pair.1 {
                    pView.addSubview(v2)
                    v2.leadingAnchor.constraint(equalTo: pView.centerXAnchor, constant: 5).isActive = true
                    v2.trailingAnchor.constraint(equalTo: pView.trailingAnchor).isActive = true
                    v2.topAnchor.constraint(equalTo: pView.topAnchor).isActive = true
                    v2.bottomAnchor.constraint(equalTo: pView.bottomAnchor).isActive = true
                }
                
                // a bit of a dank solution to deal with only one pair set
                if i == 0 && pairs.count == 1 {
                    pView.topAnchor.constraint(equalTo: pairContainer.topAnchor).isActive = true
                    pView.bottomAnchor.constraint(equalTo: pairContainer.bottomAnchor).isActive = true
                } else if i == 0 {
                    pView.topAnchor.constraint(equalTo: pairContainer.topAnchor).isActive = true
                } else if pair == pairs.last! {
                    pView.topAnchor.constraint(equalTo: pairs[i-1].0!.bottomAnchor, constant: 15).isActive = true
                    pView.bottomAnchor.constraint(equalTo: pairContainer.bottomAnchor).isActive = true
                } else {
                    pView.topAnchor.constraint(equalTo: pairs[i-1].0!.bottomAnchor, constant: 15).isActive = true
                }
                
            }
            
            relatedDungeonContainer.addSubview(pairContainer)
            pairContainer.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20).isActive = true
            pairContainer.leadingAnchor.constraint(equalTo: relatedDungeonContainer.leadingAnchor).isActive = true
            pairContainer.trailingAnchor.constraint(equalTo: relatedDungeonContainer.trailingAnchor).isActive = true
            pairContainer.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -20).isActive = true
            
            
        } else {
            let noneLabel = makeLabel(ofSize: 16, withText: "This monster does not drop or appear in dungeons")
            relatedDungeonContainer.addSubview(noneLabel)
            noneLabel.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20).isActive = true
            noneLabel.bottomAnchor.constraint(equalTo: relatedDungeonContainer.bottomAnchor, constant: -20).isActive = true
            noneLabel.centerXAnchor.constraint(equalTo: relatedDungeonContainer.centerXAnchor).isActive = true
            
        }
        
        scrollView.addSubview(relatedDungeonContainer)
        
        relatedDungeonContainer.topAnchor.constraint(equalTo: devoMaterialsContainer.bottomAnchor, constant: 20).isActive = true
        relatedDungeonContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        relatedDungeonContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
    }
}
