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
        collabContainer.setLeft(to: .leading, of: self.view, withSpacing: 0)
        collabContainer.setRight(to: self.view, withSpacing: 0)
        collabContainer.setTop(to: .bottom, of: saleCoinContainer, withSpacing: verticalAnchorSpacing)
        collabContainer.setBottom(to: .bottom, of: scrollView, withSpacing: -20)
        
        
        let header = makeLabel(ofSize: 20, withText: "Collab")
        let separator = makeSeparator()
        let collabLabel = makeLabel(ofSize: 16)

        collabContainer.addSubview(header)
        collabContainer.addSubview(separator)
        
        header.setCenterX(to: collabContainer)
        header.setTop(to: .top, of: collabContainer, withSpacing: 0)
        
        
        if monster.collabID == 0 {
            collabLabel.text = monster.name + " is not part of any collab series"
        } else {
            collabLabel.text = monster.collab
        }
        
        collabContainer.addSubview(collabLabel)
        collabLabel.setTop(to: .bottom, of: header, withSpacing: verticalAnchorSpacing)
        collabLabel.setCenterX(to: collabContainer)
        
        
        separator.setCenterX(to: collabContainer)
        separator.setTop(to: .bottom, of: collabLabel, withSpacing: verticalAnchorSpacing)
        separator.setBottom(to: .bottom, of: collabContainer, withSpacing: 0)
    
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
