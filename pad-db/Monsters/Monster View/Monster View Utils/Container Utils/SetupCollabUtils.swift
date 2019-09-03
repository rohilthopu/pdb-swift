//
//  SetupCollabUtils.swift
//  pad-db
//
//  Created by Rohil Thopu on 9/2/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit

extension MonsterView {
    func setupCollabContainer() {
        // setup the main container constraints first
        scrollView.addSubview(collabContainer)
        collabContainer.setLeftAnchor(to: .leading, of: self.view, withSpacing: 0)
        collabContainer.setRightAnchor(to: self.view, withSpacing: 0)
        collabContainer.setTopAnchor(to: .bottom, of: saleCoinContainer, withSpacing: verticalAnchorSpacing)
        collabContainer.setBottomAnchor(to: .bottom, of: scrollView, withSpacing: -20)
        
        
        let header = makeLabel(ofSize: 20, withText: "Collab")
        let separator = makeSeparator()
        let collabLabel = makeLabel(ofSize: 16)

        
        
        let widthOfContainer = UIScreen.main.bounds.width - 20
        let imgSize = widthOfContainer - 25 / 5
        
        
        collabContainer.addSubview(header)
        collabContainer.addSubview(separator)
        
        header.setCenterXAnchor(to: collabContainer)
        header.setTopAnchor(to: .top, of: collabContainer, withSpacing: 0)
        
        
        if monster.collabID == 0 {
            collabLabel.text = monster.name + " is not part of any collab series"
        } else {
            collabLabel.text = monster.collab
            
            let collabMonsters = getMonstersFromCollab(usingCollabID: monster.collabID).map{
                return makeImgView(forImg: getPortraitURL(id: $0.cardID), ofSize: imgSize)
            }
            
            let otherCollabMonstersContainer = makeView()
            var imageContainers = [UIView]()
            
            var currentImgCount = 0
            var currIndex = 0
            var imgContainer = makeView()
            var prevImage = collabMonsters[0]
            while (currIndex < collabMonsters.count) {
                let currentImage = collabMonsters[currIndex]
                if currentImage != prevImage {
                    
                } else {
                    // we are on the first image?
                    imgContainer.addSubview(currentImage)
                    currentImage.setLeftAnchor(to: .leading, of: imgContainer, withSpacing: 0)
                    currentImage.setTopAnchor(to: .top, of: imgContainer, withSpacing: 0)
                    currentImage.setBottomAnchor(to: .bottom, of: imgContainer, withSpacing: 0)
                }
            }
            
            
            
            
            
        }
        
        collabContainer.addSubview(collabLabel)
        collabLabel.setTopAnchor(to: .bottom, of: header, withSpacing: verticalAnchorSpacing)
        collabLabel.setCenterXAnchor(to: collabContainer)
        
        
        separator.setCenterXAnchor(to: collabContainer)
        separator.setTopAnchor(to: .bottom, of: collabLabel, withSpacing: verticalAnchorSpacing)
        separator.setBottomAnchor(to: .bottom, of: collabContainer, withSpacing: 0)
    
    }
    
    private func getMonstersFromCollab(usingCollabID collab_id:Int) -> [MonsterListItem] {
        if collab_id == 0 {
            return []
        }
        return monsters.filter{
            $0.collabID == collab_id
        }
    }
}
