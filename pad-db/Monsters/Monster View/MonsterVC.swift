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

class MonsterVC: UIViewController {
    
    var monster:NSManagedObject?
    var activeSkill:NSManagedObject?
    var leaderSkill:NSManagedObject?
    
    let awakening_base_link:String = "http://www.puzzledragonx.com/en/img/awoken/"
    let awakening_link_end:String = ".png"
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
        view.contentSize.height = 1800
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // make a back button
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: makeBackButton())
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.view.addSubview(scrollView)
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        
        let m_id = monster!.value(forKey: "cardID") as! Int
        self.navigationItem.title = String(m_id)
        
        setupImageView()
        setupPortraitView()
        setupNameContainer()
        setupStatusContainer()
        setupAwakenings()
        setupSuperAwakenings()
        setupSkills()
        setupEvoMaterials()
        setupDevoMaterials()
        
    }
}
