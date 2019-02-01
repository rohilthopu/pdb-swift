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
    var group:String?
    var imgLink:String?
    var remainingTime:Double?
    var status:String?
    
    var portraitImage: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var nameLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 18)
        textView.adjustsFontSizeToFitWidth = true
        return textView
    }()
    
    var groupLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        textView.clipsToBounds = true
        return textView
    }()
    
    var statusLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        return textView
    }()
    
    var remainingTimeLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        return textView
    }()
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(portraitImage)
        containerView.addSubview(nameLabel)
        containerView.addSubview(groupLabel)
        
        self.contentView.addSubview(containerView)
        self.contentView.addSubview(statusLabel)
        self.contentView.addSubview(remainingTimeLabel)
        
        
        portraitImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        portraitImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        portraitImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        portraitImage.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        anchorNameContainer()
        anchorNameLabel()
        anchorGroupLabel()
        anchorStatusLabel()
        anchorRemainingTimeLabel()

    }
    
    private func anchorStatusLabel() {
        statusLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        statusLabel.centerYAnchor.constraint(equalTo: self.nameLabel.centerYAnchor).isActive = true
    }
    
    private func anchorRemainingTimeLabel() {
        remainingTimeLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        remainingTimeLabel.topAnchor.constraint(equalTo: self.statusLabel.bottomAnchor, constant: 10).isActive = true
    }
    
    private func anchorNameContainer(){
        containerView.centerYAnchor.constraint(equalTo: portraitImage.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo: portraitImage.trailingAnchor, constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant: -75).isActive = true
    }
    
    private func anchorNameLabel(){
        nameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
    }
    
    private func anchorGroupLabel(){
        groupLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
        groupLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        groupLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
        groupLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if let name = name {
            nameLabel.text = name
        }
        
        if let group = group {
            groupLabel.text = group
        }
        
        if let status = status {
            statusLabel.text = status
        }
        
        if let link = imgLink {
            portraitImage.kf.setImage(with: URL(string: link))
        }
        
        if let remainingTime = remainingTime {
            
            let timeInMins = Int(remainingTime/60)
    
            if statusLabel.text! == "Active" {
                if timeInMins > 120 {
                    let hours = timeInMins / 60
                    remainingTimeLabel.text = String(hours) + " hours"
                    setBGcolors()
                }
                else {
                    remainingTimeLabel.text = String(timeInMins) + " minutes"
                    setBGcolors()
                }
            }
            
            else if statusLabel.text! == "Upcoming" {
                if timeInMins > 120 {
                    let hours = timeInMins / 60
                    remainingTimeLabel.text = String(hours) + " hours"
                    resetBGcolors()
                }
                else {
                    remainingTimeLabel.text = String(timeInMins) + " minutes"
                    resetBGcolors()
                }
            }
        }
    }
    
    private func setBGcolors() {
        if groupLabel.text!.contains("BLUE") {
            contentView.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        }
        else if groupLabel.text!.contains("GREEN") {
            contentView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        }
        else {
            contentView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        }
    }
    
    private func resetBGcolors() {
        contentView.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
