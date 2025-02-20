//
//  SkillCellUtils.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/14/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit

extension SkillCell {
    
    func anchorNameItems() {
        
        nameContainer.addSubview(skillIDLabel)
        nameContainer.addSubview(skillNameLabel)
        nameContainer.addSubview(skillDescriptionLabel)
        
        skillIDLabel.topAnchor.constraint(equalTo: nameContainer.topAnchor).isActive = true
        skillIDLabel.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor).isActive = true
        skillIDLabel.trailingAnchor.constraint(equalTo: nameContainer.trailingAnchor).isActive = true
        
        skillNameLabel.topAnchor.constraint(equalTo: skillIDLabel.bottomAnchor).isActive = true
        skillNameLabel.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor).isActive = true
        skillNameLabel.trailingAnchor.constraint(equalTo: nameContainer.trailingAnchor).isActive = true
        skillNameLabel.adjustsFontSizeToFitWidth = true
        
        skillDescriptionLabel.topAnchor.constraint(equalTo: skillNameLabel.bottomAnchor, constant: 5).isActive = true
        skillDescriptionLabel.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor).isActive = true
        skillDescriptionLabel.trailingAnchor.constraint(equalTo: nameContainer.trailingAnchor).isActive = true
        skillDescriptionLabel.bottomAnchor.constraint(equalTo: nameContainer.bottomAnchor).isActive = true
        skillDescriptionLabel.lineBreakMode = .byWordWrapping
        skillDescriptionLabel.numberOfLines = 0
    }
    
    func anchorImage() {
        portraitImg.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        portraitImg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        portraitImg.widthAnchor.constraint(equalToConstant: 50).isActive = true
        portraitImg.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func anchorNameContainer() {
        nameContainer.topAnchor.constraint(equalTo: portraitImg.topAnchor).isActive = true
        nameContainer.leadingAnchor.constraint(equalTo: portraitImg.trailingAnchor, constant: 10).isActive = true
        nameContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    
    func makeImgView(forImg link:String, ofSize size:CGFloat) -> UIImageView {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.kf.setImage(with: URL(string: link))
        
        img.widthAnchor.constraint(equalToConstant: size).isActive = true
        img.heightAnchor.constraint(equalToConstant: size).isActive = true
        
        return img
    }
    
    public func makeLabel(ofSize size: CGFloat, withText text: String) -> UILabel {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: size)
        textView.clipsToBounds = true
        textView.text = text
        return textView
    }

}
