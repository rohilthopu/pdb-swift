//
//  LeaderboardCell.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/13/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit

class LeaderboardCell: UITableViewCell {

    
    var user:User?
    var rank:Int?
    
    var redditUserLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 18)
        return textView
    }()
    
    var scoreLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        textView.clipsToBounds = true
        return textView
    }()
    
    var diffLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        return textView
    }()
    
    var rankLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        return textView
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(redditUserLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(diffLabel)
        contentView.addSubview(rankLabel)
        
                
        rankLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        rankLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        redditUserLabel.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 5).isActive = true
        redditUserLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        
        scoreLabel.centerYAnchor.constraint(equalTo: redditUserLabel.centerYAnchor).isActive = true
        scoreLabel.trailingAnchor.constraint(equalTo: diffLabel.leadingAnchor, constant: -20).isActive = true
        
        diffLabel.centerYAnchor.constraint(equalTo: redditUserLabel.centerYAnchor).isActive = true
        diffLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        diffLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
    }
    
    override func layoutSubviews() {
        
        if let user = user {
            
            redditUserLabel.text = user.user!
            scoreLabel.text = String(user.score!)
            diffLabel.text = "(" + String(user.scoreDiff!) + ")"
            
            if user.scoreUp! && !user.scoreDown! {
                contentView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
            }
            else if user.scoreDown! {
                contentView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
            }
            else {
                contentView.backgroundColor = UIColor.white
                diffLabel.text = ""
            }
        }
        
        if let rank = rank {
            rankLabel.text = String(rank) + "."
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
