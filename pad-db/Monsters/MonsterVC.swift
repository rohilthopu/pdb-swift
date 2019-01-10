//
//  MonsterVC.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/9/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit
import CoreData

class MonsterVC: UIViewController {
    
    var monster:NSManagedObject?
    
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
        textView.font = UIFont(name: "Futura-CondensedMedium", size: 16)
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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        // make a back button
    
        self.navigationController?.navigationBar.barTintColor = .white
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: makeBackButton())
        
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        let m_id = monster!.value(forKey: "cardID") as! Int
        self.navigationItem.title = "No. " + String(m_id)
        
        
        
    }
    
    
    func makeBackButton() -> UIButton {
        let backButtonImage = UIImage(named: "backbutton")?.withRenderingMode(.alwaysTemplate)
        let backButton = UIButton(type: .custom)
        backButton.setImage(backButtonImage, for: .normal)
        backButton.tintColor = .blue
        backButton.setTitle("Dismiss", for: .normal)
        backButton.setTitleColor(.blue, for: .normal)
        backButton.addTarget(self, action: #selector(self.backButtonPressed), for: .touchUpInside)
        return backButton
    }
    
    @objc
    func backButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillLayoutSubviews() {
        setupImageView()
        setupPortraitView()
        setupNameContainer()
    }
    
    
    private func setupImageView() {
        
        let url = URL(string: (monster!.value(forKey: "fullURL") as! String))
        imageContainer.kf.setImage(with: url)
    
        
        self.view.addSubview(imageContainer)

        imageContainer.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        imageContainer.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: -80).isActive = true
        imageContainer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    private func setupPortraitView() {
        let url = URL(string: (monster!.value(forKey: "portraitURL") as! String))
        portraitContainer.kf.setImage(with: url)
        
        self.view.addSubview(portraitContainer)
        portraitContainer.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 10).isActive = true
        portraitContainer.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 10).isActive = true
        portraitContainer.widthAnchor.constraint(equalToConstant: 60).isActive = true
        portraitContainer.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
    }
    
    private func setupNameContainer() {
        
        let id = monster!.value(forKey: "cardID") as! Int
        IDLabel.text = "No. " + String(id)
        
        nameLabel.text = monster!.value(forKey: "name") as? String
        
        var rarity = ""
        let rare = monster!.value(forKey: "rarity") as! Int
        
        for _ in 0...rare {
            rarity.append("*")
        }
        
        rarityLabel.text = rarity
        rarityCountLabel.text = " (" + String(rare) + ")"
        
        
        
        containerView.addSubview(IDLabel)
        containerView.addSubview(nameLabel)
        containerView.addSubview(rarityLabel)
        containerView.addSubview(rarityCountLabel)
        self.view.addSubview(containerView)
        
        // Container View that houses the extraneus items
        containerView.leadingAnchor.constraint(equalTo: portraitContainer.trailingAnchor, constant: 10).isActive = true
        containerView.topAnchor.constraint(equalTo: portraitContainer.topAnchor).isActive = true
        containerView.heightAnchor.constraint(equalTo: portraitContainer.heightAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        IDLabel.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        IDLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: IDLabel.bottomAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        
        
        rarityLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        rarityLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        rarityCountLabel.leadingAnchor.constraint(equalTo: rarityLabel.trailingAnchor).isActive = true
        rarityCountLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
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
