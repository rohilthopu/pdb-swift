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
        collabContainer.setMyLeft(to: .leading, of: self.view, withSpacing: 0)
        collabContainer.setMyRight(to: self.view, withSpacing: 0)
        collabContainer.setMyTop(to: .bottom, of: saleCoinContainer, withSpacing: verticalAnchorSpacing)
        collabContainer.setMyBottom(to: .bottom, of: scrollView, withSpacing: -20)
        
        
        let header = makeLabel(ofSize: 20, withText: "Collab")
        let separator = makeSeparator()
        let collabLabel = makeLabel(ofSize: 16)

        collabContainer.addSubview(header)
        collabContainer.addSubview(separator)
        
        header.setMyCenterX(to: collabContainer)
        header.setMyTop(to: .top, of: collabContainer, withSpacing: 0)
        
        
        if monster.collabID == 0 {
            collabLabel.text = monster.name + " is not part of any collab series"
        } else {
            collabLabel.text = monster.collab
        }
        
        collabContainer.addSubview(collabLabel)
        collabLabel.setMyTop(to: .bottom, of: header, withSpacing: verticalAnchorSpacing)
        collabLabel.setMyCenterX(to: collabContainer)
        
        
        separator.setMyCenterX(to: collabContainer)
        separator.setMyTop(to: .bottom, of: collabLabel, withSpacing: verticalAnchorSpacing)
        separator.setMyBottom(to: .bottom, of: collabContainer, withSpacing: 0)
    
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
