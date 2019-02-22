//
//  ViewUtils.swift
//  pad-db
//
//  Created by Rohil Thopu on 2/22/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit

func makeView() -> UIView {
    let vw = UIView()
    vw.translatesAutoresizingMaskIntoConstraints = false
    vw.clipsToBounds = true
    return vw
}

func makeSeparator() -> UIView {
    let separator = UIView()
    separator.translatesAutoresizingMaskIntoConstraints = false
    separator.clipsToBounds = true
    separator.layer.borderWidth = 1
    separator.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    separator.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 3 / 4).isActive = true
    return separator
}

func makeImgView(forImg link:String, ofSize size:CGFloat) -> UIImageView {
    let img = UIImageView()
    img.translatesAutoresizingMaskIntoConstraints = false
    img.clipsToBounds = true
    img.kf.setImage(with: URL(string: link))
    img.widthAnchor.constraint(equalToConstant: size).isActive = true
    img.heightAnchor.constraint(equalToConstant: size).isActive = true
    img.layer.cornerRadius = 3
    
    return img
}

func makeImgView(fromIconName icon:String, ofSize size:CGFloat) -> UIImageView {
    let img = UIImageView()
    img.translatesAutoresizingMaskIntoConstraints = false
    img.clipsToBounds = true
    img.image = UIImage(named: icon)
    img.heightAnchor.constraint(equalToConstant: size).isActive = true
    img.widthAnchor.constraint(equalToConstant: size).isActive = true
    
    return img
}

func makeLabel(ofSize size: CGFloat, withText text: String) -> UILabel {
    let textView = UILabel()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.font = UIFont(name: "Futura-CondensedMedium", size: size)
    textView.clipsToBounds = true
    textView.text = text
    return textView
}

func makeHeader(forContainer container:UIView, withHeader header:UILabel, withSeparator separator:UIView) {
    container.addSubview(header)
    header.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
    header.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
    
    container.addSubview(separator)
    separator.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
    separator.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
    
}
