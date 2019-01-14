//
//  SetupAwakeningUtils.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/13/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit

extension MonsterVC {
    public func setupAwakenings() {
        let size = CGFloat(20)
        let size_int = 20
        
        let awks = monster!.value(forKey: "awakenings") as! [Int]
        
        
        var diff:CGFloat = 0
        
        for a in awks {
            let img = makeImgView(fromIconName: String(a + 2), ofSize: size)
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
        awakeningContainer.topAnchor.constraint(equalTo: statContainer.bottomAnchor, constant: 20).isActive = true
        
        separator.bottomAnchor.constraint(equalTo: awakeningContainer.bottomAnchor).isActive = true
        separator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        if awks.count > 0 {
            for i in 0...awakenings.count - 1 {
                let skill = awakenings[i]
                
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
            let awokenNoneLabel = makeLabel(ofSize: 16, withText: "No Awoken Skills")
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
            let img = makeImgView(fromIconName:  String(a + 2), ofSize: size)
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
            let sawokenNoneLabel = makeLabel(ofSize: 16, withText: "No Super Awoken Skills")
            sawakeningContainer.addSubview(sawokenNoneLabel)
            sawokenNoneLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
            sawokenNoneLabel.centerYAnchor.constraint(equalTo: sawakeningContainer.centerYAnchor).isActive = true
            sawokenNoneLabel.trailingAnchor.constraint(lessThanOrEqualTo: sawakeningContainer.trailingAnchor).isActive = true
        }
    }
}
