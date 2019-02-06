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
        let skillVC = SkillTableVC()
        let dungeonVC = DungeonListTableViewController()
        let leaderVC = LeaderboardTableVC()
        
        guerrillaVC.tabBarItem = UITabBarItem(title: "Events", image: UIImage(named: "calendar"), tag: 0)
        monsterNAVC.tabBarItem = UITabBarItem(title: "Monsters", image: UIImage(named: "list"), tag: 1)
        skillVC.tabBarItem = UITabBarItem(title: "Skills", image: UIImage(named: "swords"), tag: 2)
        dungeonVC.tabBarItem = UITabBarItem(title: "Dungeons", image: UIImage(named: "list"), tag: 3)
        leaderVC.tabBarItem = UITabBarItem(title: "Ranking", image: UIImage(named: "rank"), tag: 4)
        let tabViews = [guerrillaVC, monsterNAVC, skillVC, dungeonVC, leaderVC]
                
        viewControllers = tabViews.map{UINavigationController(rootViewController: $0)}
    }

}