//
//  DungeonFloorCell.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/29/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit
import CoreData

class DungeonFloorCell: UITableViewCell {
    
    var floor:NSManagedObject?
    
    var floorImage:UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.clipsToBounds = true
        return img
    }()
    
    let nameContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let floorNameLabel:UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        textView.clipsToBounds = true
        return textView
    }()
    
    let floorWavesLabel:UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 12)
        textView.clipsToBounds = true
        return textView
    }()
    
    let dungeonIDLabel:UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 12)
        textView.clipsToBounds = true
        return textView
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameContainer)
        contentView.addSubview(floorImage)
        anchorNameItems()
        anchorImage()
        anchorNameContainer()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let floor = floor {
            floorNameLabel.text = (floor.value(forKey: "name") as! String)
            floorWavesLabel.text = "Waves: " + String(floor.value(forKey: "waves") as! Int)
        }
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
        nameContainer.topAnchor.constraint(equalTo: floorImage.topAnchor).isActive = true
        nameContainer.leadingAnchor.constraint(equalTo: floorImage.trailingAnchor, constant: 10).isActive = true
        nameContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    private func anchorNameItems() {
        
        nameContainer.addSubview(floorWavesLabel)
        nameContainer.addSubview(floorNameLabel)
        
        
        floorWavesLabel.topAnchor.constraint(equalTo: nameContainer.topAnchor).isActive = true
        floorWavesLabel.trailingAnchor.constraint(equalTo: nameContainer.trailingAnchor).isActive = true
        floorWavesLabel.leadingAnchor.constraint(equalTo: floorNameLabel.trailingAnchor).isActive = true
    
        
        floorNameLabel.topAnchor.constraint(equalTo: nameContainer.topAnchor).isActive = true
        floorNameLabel.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor).isActive = true
        floorNameLabel.trailingAnchor.constraint(equalTo: nameContainer.trailingAnchor).isActive = true
        floorNameLabel.bottomAnchor.constraint(equalTo: nameContainer.bottomAnchor).isActive = true
        floorNameLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    private func anchorImage() {
        floorImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        floorImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        floorImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        floorImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
