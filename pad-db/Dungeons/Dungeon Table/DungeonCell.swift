//
//  SkillCell.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/14/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit
import CoreData

class DungeonCell: UITableViewCell {
    
    
    var dungeon:NSManagedObject?
    
    var dungeonImage:UIImageView = {
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
    
    let dungeonNameLabel:UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        textView.clipsToBounds = true
        textView.adjustsFontSizeToFitWidth = true
        return textView
    }()
    
    let floorCountLabel:UILabel = {
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
        contentView.addSubview(dungeonImage)
        anchorNameItems()
        anchorImage()
        anchorNameContainer()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let dungeon = dungeon {
            dungeonNameLabel.text = (dungeon.value(forKey: "name") as! String)
            dungeonIDLabel.text = "No. " + String((dungeon.value(forKey: "dungeonID") as! Int))
            floorCountLabel.text = "Floors: " + String(dungeon.value(forKey: "floorCount") as! Int)
            
            let imageLinkFromID = URL(string: portrait_url + String(dungeon.value(forKey: "imageID") as! Int) + pngEngding)
            dungeonImage.kf.setImage(with: imageLinkFromID)
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
        nameContainer.topAnchor.constraint(equalTo: dungeonImage.topAnchor).isActive = true
        nameContainer.leadingAnchor.constraint(equalTo: dungeonImage.trailingAnchor, constant: 10).isActive = true
        nameContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    private func anchorNameItems() {
        
        nameContainer.addSubview(floorCountLabel)
        nameContainer.addSubview(dungeonNameLabel)
        nameContainer.addSubview(dungeonIDLabel)
        
        
        floorCountLabel.topAnchor.constraint(equalTo: nameContainer.topAnchor).isActive = true
        floorCountLabel.trailingAnchor.constraint(equalTo: nameContainer.trailingAnchor).isActive = true
        floorCountLabel.leadingAnchor.constraint(equalTo: dungeonIDLabel.trailingAnchor).isActive = true
        
        dungeonIDLabel.topAnchor.constraint(equalTo: nameContainer.topAnchor).isActive = true
        dungeonIDLabel.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor).isActive = true
        
        dungeonNameLabel.topAnchor.constraint(equalTo: dungeonIDLabel.bottomAnchor).isActive = true
        dungeonNameLabel.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor).isActive = true
        dungeonNameLabel.trailingAnchor.constraint(equalTo: nameContainer.trailingAnchor).isActive = true
        dungeonNameLabel.bottomAnchor.constraint(equalTo: nameContainer.bottomAnchor).isActive = true
        dungeonNameLabel.adjustsFontSizeToFitWidth = true

    }
    
    private func anchorImage() {
        dungeonImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        dungeonImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        dungeonImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        dungeonImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
