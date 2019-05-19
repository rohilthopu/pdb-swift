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
    
    var monster:Monster?
    var activeSkill:NSManagedObject?
    var leaderSkill:NSManagedObject?
    
    let type_base:String = "type_"
    var awakenings = [UIImageView]()
    var sawakenings = [UIImageView]()
    var types = [UIImageView]()
    var evoImgs = [UIImageView]()
    var devoImgs = [UIImageView]()
    let noString = ""
    
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
    
    let statContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    let nameContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    
    let levelContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    
    let HPContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    
    let ATKContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    
    let RCVContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    
    // xp labels
    
    let XPContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    // weighted stats label
    
    let weightedStatsLabel: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        return textView
    }()
    
    
    let awakeningContainer: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.clipsToBounds = true
        return vw
    }()
    
    let sawakeningContainer: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.clipsToBounds = true
        return vw
    }()
    
    let evoMaterialsContainer: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.clipsToBounds = true
        return vw
    }()
    
    let devoMaterialsContainer: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.clipsToBounds = true
        return vw
    }()
    
    let activeSkillContainer: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.clipsToBounds = true
        return vw
    }()
    
    let leaderSkillContainer: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.clipsToBounds = true
        return vw
    }()
    
    let saleMPContainer: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.clipsToBounds = true
        return vw
    }()
    
    let saleCoinContainer: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.clipsToBounds = true
        return vw
    }()
    
    let relatedDungeonContainer: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.clipsToBounds = true
        return vw
    }()
    
    let enemySkillContainer: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.clipsToBounds = true
        return vw
    }()
    
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
        
        
        let m_id = monster!.cardID
        self.navigationItem.title = String(m_id)
        
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
        setupRelatedDungeons()
        setupSaleItems()
        
    }
    
}
