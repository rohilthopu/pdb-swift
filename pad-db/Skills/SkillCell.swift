//
//  SkillCell.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/14/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit
import CoreData

class SkillCell: UITableViewCell {

    
    var skill:NSManagedObject?
    var monster:NSManagedObject?
    
    var portraitImg:UIImageView = {
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
    
    let skillIDLabel:UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 12)
        textView.clipsToBounds = true
        return textView
    }()
    
    let skillNameLabel:UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        textView.clipsToBounds = true
        return textView
    }()
    
    let skillDescriptionLabel:UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 12)
        textView.clipsToBounds = true
        return textView
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameContainer)
        contentView.addSubview(portraitImg)
        anchorNameItems()
        anchorImage()
        anchorNameContainer()
        
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let skill = skill {
            skillIDLabel.text = "No." + String(skill.value(forKey: "skillID") as! Int)
            skillNameLabel.text = (skill.value(forKey: "name") as! String)
            skillDescriptionLabel.text = (skill.value(forKey: "desc") as! String)
        }
        if let monster = monster {
            let url = URL(string: monster.value(forKey: "portraitURL") as! String)            
            portraitImg.kf.setImage(with: url)
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
}
