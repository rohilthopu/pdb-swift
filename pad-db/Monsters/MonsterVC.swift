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
    var monsters:[NSManagedObject]?
    
    let awakening_base_link:String = "http://www.puzzledragonx.com/en/img/awoken/"
    let awakening_link_end:String = ".png"
    let type_base:String = "type_"
    var awakenings = [UIImageView]()
    var sawakenings = [UIImageView]()
    var types = [UIImageView]()
    var evoImgs = [UIImageView]()
    var devoImgs = [UIImageView]()
    
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
    
    var nameLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        
        return textView
    }()
    
    var IDLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 20)
        textView.textColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        return textView
    }()
    
    var rarityLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 20)
        return textView
    }()
    
    var rarityCountLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 12)
        return textView
    }()
    
    
    let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    
    // labels for the status
    
    var levelLabel: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 20)
        return textView
    }()
    
    var minLevelLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        
        return textView
    }()
    
    var maxLevelLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        
        return textView
    }()
    
    var label297: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        
        return textView
    }()
    
    let levelContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    
    
    // hp labels
    var HPLabel: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 20)
        return textView
    }()
    
    var minHPLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        
        return textView
    }()
    
    var maxHPLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        
        return textView
    }()
    
    var hp297: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        
        return textView
    }()
    
    let HPContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    
    
    // atk labels
    
    var ATKLabel: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 20)
        return textView
    }()
    
    var minATKLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        
        return textView
    }()
    
    var maxATKLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        
        return textView
    }()
    
    var atk297: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        
        return textView
    }()
    
    let ATKContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    
    // rcv labels
    
    var RCVLabel: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 20)
        return textView
    }()
    
    var minRCVLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        
        return textView
    }()
    
    var maxRCVLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        
        return textView
    }()
    
    var rcv297: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        
        return textView
    }()
    
    let RCVContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    
    // xp labels
    
    
    var XPLabel: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 20)
        return textView
    }()
    
    var minXPLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        
        return textView
    }()
    
    var maxXPLabel: UILabel = {
        var textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        
        return textView
    }()
    
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
    
    let awokenSkillLabel: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        textView.clipsToBounds = true
        textView.text = "Awoken Skill"
        return textView
    }()
    
    let sawokenSkillLabel: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        textView.clipsToBounds = true
        textView.text = "Super Awoken Skills"
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
    
    let evoMaterialsLabel: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        textView.clipsToBounds = true
        textView.text = "Evolution Materials"
        return textView
    }()
    
    let evoMaterialsContainer: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.clipsToBounds = true
        return vw
    }()
    
    let evoNoneLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.clipsToBounds = true
        lbl.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        lbl.text = "No Evolution Materials"
        return lbl
    }()
    
    
    let devoMaterialsLabel: UILabel = {
        let textView = UILabel()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        textView.clipsToBounds = true
        textView.text = "Devolution Materials"
        return textView
    }()
    
    let devoMaterialsContainer: UIView = {
        let vw = UIView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.clipsToBounds = true
        return vw
    }()
    
    let devoNoneLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.clipsToBounds = true
        lbl.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        lbl.text = "No Devolution Materials"
        return lbl
    }()
    
    let awokenNoneLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.clipsToBounds = true
        lbl.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        lbl.text = "No Awoken Skills"
        return lbl
    }()
    
    let sawokenNoneLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.clipsToBounds = true
        lbl.font = UIFont(name: "Futura-CondensedMedium", size: 16)
        lbl.text = "No Super Awoken Skills"
        return lbl
    }()
    
  
    
    let scrollView:UIScrollView = {
       let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize.height = 1200
        view.backgroundColor = UIColor.white
        return view
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
        addSeparator()
        
    }
}
