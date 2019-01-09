//
//  MonsterCell.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/8/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit

class MonsterCell: UITableViewCell {
    
    
    var name:String?
    
    var nameLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .boldSystemFont(ofSize: 16)
        return textView
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
        contentView.addSubview(nameLabel)
        nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true

    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let name = name {
            nameLabel.text = name
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
