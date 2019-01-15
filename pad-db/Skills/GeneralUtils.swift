//
//  GeneralUtils.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/14/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit

extension SkillTableVC {
    func makeImgView(forImg link:String, ofSize size:CGFloat) -> UIImageView {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        img.kf.setImage(with: URL(string: link))
        
        img.widthAnchor.constraint(equalToConstant: size).isActive = true
        img.heightAnchor.constraint(equalToConstant: size).isActive = true
        
        return img
    }
}
