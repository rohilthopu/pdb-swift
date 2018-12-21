//
//  GuerrillaCell.swift
//  pad-db
//
//  Created by Rohil Thopu on 12/19/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit
import Foundation

class GuerrillaCell: UITableViewCell {
    

    var name:String?
    var startSecs:Float?
    var endSecs:Float?
    var server:String?
    var group:String?
    var dungeon_id:Int?
    var remainingTime:Float?
    var status:String?
    
    var nameLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .boldSystemFont(ofSize: 16)
        return textView
    }()
    
    var groupLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .systemFont(ofSize: 12)
        textView.clipsToBounds = true
        return textView
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(groupLabel)
        
        self.contentView.addSubview(containerView)
        
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 25).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        
        
        groupLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
        groupLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        groupLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
        groupLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true

//        anchorNameView()
//        anchorGroupView()
    }
    
//    private func anchorNameView(){
//        nameView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        nameView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        nameView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        nameView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//    }
    
    private func anchorGroupView(){
//        groupView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        groupView.leftAnchor.constraint(equalTo: self.nameView.rightAnchor).isActive = true
//        groupView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//        groupView.topAnchor.constraint(equalTo: self.nameView.bottomAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let name = name {
            nameLabel.text = name
        }
        
        if let group = group {
            groupLabel.text = group
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
