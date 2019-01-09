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


        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
