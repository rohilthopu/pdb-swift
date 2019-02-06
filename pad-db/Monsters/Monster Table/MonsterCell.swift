//
//  MonsterCell.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/8/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit
import CoreData
import Kingfisher


class MonsterCell: UITableViewCell {
    
    var monster:NSManagedObject?
    
    var nameLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        textView.adjustsFontSizeToFitWidth = true
        return textView
    }()
    
    var monsterIDLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 12)
        textView.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return textView
    } ()
    
    var portraitContainer: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let nameContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(portraitContainer)
        nameContainer.addSubview(monsterIDLabel)
        nameContainer.addSubview(nameLabel)
        contentView.addSubview(nameContainer)

        
        portraitContainer.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        portraitContainer.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        portraitContainer.widthAnchor.constraint(equalToConstant: 50).isActive = true
        portraitContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        // Container View that houses the extraneus items
        nameContainer.leadingAnchor.constraint(equalTo: portraitContainer.trailingAnchor, constant: 10).isActive = true
        nameContainer.topAnchor.constraint(equalTo: portraitContainer.topAnchor).isActive = true
        nameContainer.bottomAnchor.constraint(equalTo: portraitContainer.bottomAnchor).isActive = true
        nameContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        
        monsterIDLabel.topAnchor.constraint(equalTo: nameContainer.topAnchor).isActive = true
        monsterIDLabel.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: monsterIDLabel.bottomAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: nameContainer.trailingAnchor).isActive = true

    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let monster = monster {
            nameLabel.text = monster.value(forKey: "name") as? String
            
            let id = monster.value(forKey: "cardID") as! Int
            monsterIDLabel.text = "No. " + String(id)
            // Get the portrait image using Kingfisher
            let url = URL(string: getPortraitURL(id: (monster.value(forKey: "cardID") as! Int)))
            portraitContainer.kf.setImage(with: url)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
