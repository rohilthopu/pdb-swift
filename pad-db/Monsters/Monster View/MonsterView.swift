//
//  MonsterVC.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/9/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit
import CoreData
import CoreGraphics


class MonsterView: UIViewController {
    
    var spacing:CGFloat = 0
    let verticalAnchorSpacing: CGFloat = 20
    
    var monster:Monster
    var activeSkill:Skill?
    var leaderSkill:Skill?
    
    let type_base:String = "type_"
    var awakenings = [UIImageView]()
    var sawakenings = [UIImageView]()
    var types = [UIImageView]()
    var evoImgs = [UIImageView]()
    var devoImgs = [UIImageView]()
    
    let scrollView:UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let imageContainer: UIImageView =  {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        img.backgroundColor = UIColor.black
        return img
    }()
    
    let portraitContainer: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.clipsToBounds = true
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    let statContainer: UIView = makeView()
    let nameContainer: UIView = makeView()
    let levelContainer: UIView = makeView()
    let HPContainer: UIView = makeView()
    let ATKContainer: UIView = makeView()
    let RCVContainer: UIView = makeView()
    let XPContainer: UIView = makeView()
    let awakeningContainer: UIView = makeView()
    let sawakeningContainer: UIView = makeView()
    let evoMaterialsContainer: UIView = makeView()
    let devoMaterialsContainer: UIView = makeView()
    let activeSkillContainer: UIView = makeView()
    let leaderSkillContainer: UIView = makeView()
    let saleMPContainer: UIView = makeView()
    let saleCoinContainer: UIView = makeView()
    let relatedDungeonContainer: UIView = makeView()
    let enemySkillContainer: UIView = makeView()
    let collabContainer: UIView = makeView()
    let seriesContainer:UIView = makeView()
    
    init(monster:Monster) {
        self.monster = monster
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spacing = (self.view.frame.width)/50
        
        if #available(iOS 11, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        
        self.view.addSubview(scrollView)
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.heightAnchor.constraint(equalTo: self.view.heightAnchor).isActive = true
        
        
        self.navigationItem.title = String(monster.cardID)
        
        setupImageView()
        setupPortraitView()
        setupNameContainer()
        setupStatusContainer()
        setupAwakenings()
        setupSuperAwakenings()
        setupSkills()
        //        setupEnemySkills()
        setupEvoMaterials()
        setupDevoMaterials()
//        setupRelatedDungeons()
        setupSaleItems()
        setupCollabContainer()
        setupSeriesContainer()
    }
}
