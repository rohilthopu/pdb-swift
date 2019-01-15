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
        let leaderVC = LeaderboardTableVC()
        
        guerrillaVC.tabBarItem = UITabBarItem(title: "Events", image: UIImage(named: "calendar"), tag: 0)
        monsterNAVC.tabBarItem = UITabBarItem(title: "Monster", image: UIImage(named: "list"), tag: 1)
        leaderVC.tabBarItem = UITabBarItem(title: "Ranking", image: UIImage(named: "rank"), tag: 2)
        let tabViews = [guerrillaVC, monsterNAVC, leaderVC]
                
        viewControllers = tabViews.map{UINavigationController(rootViewController: $0)}
    }

}
