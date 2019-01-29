//
//  File.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/24/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit


extension DungeonListTableViewController {
    func setupView() {
        self.navigationItem.title = "Dungeons"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }
}
