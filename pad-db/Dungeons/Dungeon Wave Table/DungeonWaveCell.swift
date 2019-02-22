//
//  SkillCell.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/14/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit
import CoreData

class DungeonWaveCell: UITableViewCell {
    
    var numEncounters:Int?
    var waveNumber:Int?
    
    let nameContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let waveLabel:UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 20)
        textView.clipsToBounds = true
        textView.adjustsFontSizeToFitWidth = true
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameContainer)
        anchorNameItems()
        anchorNameContainer()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        waveLabel.text = "Wave \(waveNumber!)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func anchorNameContainer() {
        nameContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        nameContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        nameContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
    }
    
    private func anchorNameItems() {
        
        nameContainer.addSubview(waveLabel)
        waveLabel.topAnchor.constraint(equalTo: nameContainer.topAnchor).isActive = true
        waveLabel.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor).isActive = true
        waveLabel.trailingAnchor.constraint(equalTo: nameContainer.trailingAnchor).isActive = true
        waveLabel.bottomAnchor.constraint(equalTo: nameContainer.bottomAnchor).isActive = true
        
    }
}
