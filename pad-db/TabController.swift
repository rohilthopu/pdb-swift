//
//  TabController.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/8/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let guerrillaVC = GuerrillaTableViewController()
        let monsterNAVC = MonsterTableController()
        
        guerrillaVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 0)
        monsterNAVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        let tabViews = [guerrillaVC, monsterNAVC]
                
        viewControllers = tabViews.map{UINavigationController(rootViewController: $0)}
    }

}
