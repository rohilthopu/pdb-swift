//
//  series_utils.swift
//  pad-db
//
//  Created by Rohil Thopu on 9/3/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit

extension MonsterView {
    func setupSeriesContainer() {
        // setup the main container constraints first
        scrollView.addSubview(seriesContainer)
        seriesContainer.setLeftAnchor(to: .leading, of: self.view, withSpacing: 0)
        seriesContainer.setRightAnchor(to: self.view, withSpacing: 0)
        seriesContainer.setTopAnchor(to: .bottom, of: collabContainer, withSpacing: verticalAnchorSpacing)
        seriesContainer.setBottomAnchor(to: .bottom, of: scrollView, withSpacing: verticalAnchorSpacing)
        
        
        let header = makeLabel(ofSize: 20, withText: "Series")
        let separator = makeSeparator()
        let seriesLabel = makeLabel(ofSize: 16)

        
        let imgSize = CGFloat(60)
        
        seriesContainer.addSubview(header)
        seriesContainer.addSubview(separator)
        seriesContainer.addSubview(seriesLabel)

        header.setCenterXAnchor(to: seriesContainer)
        header.setTopAnchor(to: .top, of: seriesContainer, withSpacing: 0)
        
        
        if monster.seriesID == 0 || monster.collabID != 0 {
            if monster.collabID != 0 {
                seriesLabel.text = monster.name + " is part of the " + monster.collab
            } else {
                seriesLabel.text = monster.name + " is not part of any series"
            }
            seriesLabel.lineBreakMode = .byWordWrapping
            seriesLabel.numberOfLines = 0
            seriesLabel.setBottomAnchor(to: .top, of: separator, withSpacing: verticalAnchorSpacing)
        } else {
            seriesLabel.text = monster.series
            
            let seriesMonsters = getMonstersFromSeries(usingSeriesID: monster.seriesID).map{
                return makeImgView(forImg: getPortraitURL(id: $0.cardID), ofSize: imgSize)
            }
            
            let imageContainers = makeHorizontalImageRows(forMonsters: seriesMonsters)
            let otherSeriesMonstersContainer = makeLargeContainer(forImageRows: imageContainers)
            
            seriesContainer.addSubview(otherSeriesMonstersContainer)
            
            otherSeriesMonstersContainer.setTopAnchor(to: .bottom, of: seriesLabel, withSpacing: 20)
            otherSeriesMonstersContainer.setLeftAnchor(to: .leading, of: seriesContainer)
            otherSeriesMonstersContainer.setRightAnchor(to: seriesContainer)
            otherSeriesMonstersContainer.setBottomAnchor(to: .top, of: separator, withSpacing: verticalAnchorSpacing)
        
        }
        
        seriesLabel.setTopAnchor(to: .bottom, of: header, withSpacing: verticalAnchorSpacing)
        seriesLabel.setCenterXAnchor(to: seriesContainer)
        
        
        separator.setCenterXAnchor(to: seriesContainer)
        separator.setBottomAnchor(to: .bottom, of: seriesContainer, withSpacing: 0)
    
    }
    
    private func getMonstersFromSeries(usingSeriesID seriesID:Int) -> [MonsterListItem]{
        if seriesID == 0 {
            return []
        }
        return goodMonsters.filter{
            $0.seriesID == seriesID
        }
    }
}
