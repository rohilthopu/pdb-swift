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

        
        let guerrillaVC = GuerrillaTable()
        let monsterVC = MonsterTable()
        let skillVC = SkillTable()
        let dungeonVC = DungeonTable()
        let settingsVC = SettingsViewController()
        
        guerrillaVC.tabBarItem = UITabBarItem(title: "Events", image: UIImage(named: "calendar"), tag: 0)
        monsterVC.tabBarItem = UITabBarItem(title: "Monsters", image: UIImage(named: "list"), tag: 1)
        skillVC.tabBarItem = UITabBarItem(title: "Skills", image: UIImage(named: "swords"), tag: 2)
        dungeonVC.tabBarItem = UITabBarItem(title: "Dungeons", image: UIImage(named: "list"), tag: 3)
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(named: "settings"), tag: 4)
        let tabViews = [monsterVC, skillVC, dungeonVC, settingsVC]
                
        viewControllers = tabViews.map{UINavigationController(rootViewController: $0)}
    }

}
