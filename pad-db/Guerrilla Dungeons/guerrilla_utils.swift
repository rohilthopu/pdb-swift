//
//  GuerrillaUtils.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/17/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

extension GuerrillaTable {
    
    func setupNavBar() {
        if #available(iOS 11, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
    
        navigationItem.title = "NA Calendar"
        let server = UIBarButtonItem(image: UIImage(named: "world")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(swapServer))
  
        navigationItem.leftBarButtonItem = server
    }

    
    @objc
    func swapServer() {
        
        if showingNA {
            displayDungeons = jpDungeons
            showingNA = false
            navigationItem.title = "JP Calendar"
            self.tableView.reloadData()
        }
        else {
            displayDungeons = naDungeons
            showingNA = true
            navigationItem.title = "NA Calendar"
            self.tableView.reloadData()
        }
    }
    
    @objc
    func refreshGuerrillaList(_ sender: Any) {
        naDungeons.removeAll()
        jpDungeons.removeAll()
        tableView.reloadData()
        
        DispatchQueue.global(qos: .background).async {
            getLiveGuerrillaData()
            
            DispatchQueue.main.async {
                self.tableView.refreshControl!.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
}
