//
//  LoadDataVC.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/17/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit
import Kingfisher
import SwiftyJSON
import CoreData

class LoadDataVC: UIViewController {
    
    let updateLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLabel.translatesAutoresizingMaskIntoConstraints = false
        updateLabel.clipsToBounds = true
        updateLabel.font = UIFont(name: "Futura-CondensedMedium", size: 20)
        updateLabel.text = "Downloading data..."
        self.view.addSubview(updateLabel)
        updateLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        updateLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getNewData()
        self.dismiss(animated: true, completion: nil)
    }
}
