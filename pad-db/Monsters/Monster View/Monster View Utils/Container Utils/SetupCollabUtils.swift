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
        collabContainer.addSubview(collabLabel)

        header.setCenterXAnchor(to: collabContainer)
        header.setTopAnchor(to: .top, of: collabContainer, withSpacing: 0)
        
        
        if monster.collabID == 0 {
            collabLabel.text = monster.name + " is not part of any collab series"
            collabLabel.setBottomAnchor(to: .top, of: separator, withSpacing: verticalAnchorSpacing)
        } else {
            collabLabel.text = monster.collab
            
            let collabMonsters = getMonstersFromCollab(usingCollabID: monster.collabID).map{
                return makeImgView(forImg: getPortraitURL(id: $0.cardID), ofSize: imgSize)
            }
            
            var imageContainers = [UIView]()
            
            var currentImgCount = 0
            var currIndex = 0
            // a horizontal image container
            var imgContainer = makeView()
            var prevImage = collabMonsters[0]
            while (currIndex < collabMonsters.count) {
                let currentImage = collabMonsters[currIndex]
                imgContainer.addSubview(currentImage)
                currentImage.setTopAnchor(to: .top, of: imgContainer)
                currentImage.setBottomAnchor(to: .bottom, of: imgContainer)
                if currentImage != prevImage {
                    currentImage.setLeftAnchor(to: .trailing, of: prevImage, withSpacing: 5)
                } else {
                    // we are on the first image?
                    currentImage.setLeftAnchor(to: .leading, of: imgContainer)
                }
                // store the previous image
                prevImage = currentImage
                currentImgCount += 1
                currIndex += 1
                
                if currentImgCount == 5 || currIndex == collabMonsters.count {
                    currentImgCount = 0
                    imageContainers.append(imgContainer)
                    imgContainer = makeView()
                    currentImage.setRightAnchor(to: imageContainer)
                }
            }
            
            let otherCollabMonstersContainer = makeView()

            currIndex = 0
            var prevContainer = imageContainers[0]
            while (currIndex < imageContainers.count) {
                let currentContainer = imageContainers[currIndex]
                otherCollabMonstersContainer.addSubview(currentContainer)
                currentContainer.setLeftAnchor(to: .leading, of: otherCollabMonstersContainer)
                currentContainer.setRightAnchor(to: otherCollabMonstersContainer)
                currentContainer.setCenterXAnchor(to: otherCollabMonstersContainer)
                
                
                if currIndex == 0 {
                    // set the main anchors
                    currentContainer.setTopAnchor(to: .top, of: otherCollabMonstersContainer)
                    
                } else {
                    currentContainer.setTopAnchor(to: .bottom, of: prevContainer, withSpacing: 10)
                }
                
                currIndex += 1
                prevContainer = currentContainer
                
                if currIndex == imageContainers.count {
                    currentContainer.setBottomAnchor(to: .bottom, of: otherCollabMonstersContainer)
                }
            }
            
            
            collabContainer.addSubview(otherCollabMonstersContainer)
            
            otherCollabMonstersContainer.setTopAnchor(to: .bottom, of: collabLabel, withSpacing: 20)
            otherCollabMonstersContainer.setLeftAnchor(to: .leading, of: collabContainer)
            otherCollabMonstersContainer.setRightAnchor(to: collabContainer)
            otherCollabMonstersContainer.setBottomAnchor(to: .top, of: separator, withSpacing: verticalAnchorSpacing)
        
        }
        
        collabLabel.setTopAnchor(to: .bottom, of: header, withSpacing: verticalAnchorSpacing)
        collabLabel.setCenterXAnchor(to: collabContainer)
        
        
        separator.setCenterXAnchor(to: collabContainer)
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
