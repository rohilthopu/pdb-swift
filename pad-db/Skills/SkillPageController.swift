//
//  SkillPageController.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/23/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit

class SkillPageController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    let vc1 = UINavigationController(rootViewController: SkillTableVC())
    let vc2 = UIViewController()
    
    var pageViews = [UIViewController]()
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currIndex = getIndex(ofViewController: viewController)
        if currIndex - 1 >= 0 {
            return pageViews[currIndex - 1]
        }
        return pageViews[1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currIndex = getIndex(ofViewController: viewController)
        if currIndex + 1 < pageViews.count {
            return pageViews[currIndex + 1]
        }
        return pageViews[0]
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: UIPageViewController.TransitionStyle.scroll, navigationOrientation: navigationOrientation, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        vc2.view.backgroundColor = UIColor.red
        pageViews.append(vc1)
        pageViews.append(vc2)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.setViewControllers([pageViews[0]], direction: UIPageViewController.NavigationDirection.forward, animated: false, completion: nil)
    }
    
    func getIndex(ofViewController viewController: UIViewController) -> Int {
        if let index = pageViews.index(of: viewController) {
            return index
        } else {
            return -1
        }
    }

}
