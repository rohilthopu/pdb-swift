//
//  MonsterTableController.swift
//  pad-db
//
//  Created by Rohil Thopu on 8/9/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
import CoreData


extension MonsterTableController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForText(searchController.searchBar.text!)
    }
}

class MonsterTableController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    let cellid = "monsterid"
    
    
    var filteredMonsters = [NSManagedObject]()
    var monsterSearchController:UISearchController!
    
    var isDescendedSort:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
        filterGoodMonsters()
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if goodMonsters.count == 0 {
            filterGoodMonsters()
        }
        self.tableView.reloadData()
    }
    
    private func filterGoodMonsters() {
        goodMonsters = monsters.filter{
            let name = $0.value(forKey: "name") as! String
            return !name.contains("Alt.") && !name.contains("*") && !name.contains("?")
        }
    }
    
    private func setupTableView() {
        tableView.register(MonsterCell.self, forCellReuseIdentifier: cellid)
        tableView.rowHeight = 70
    }
    
    private func setupNavBar() {
        if #available(iOS 11, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        navigationItem.title = "Monsters"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "order")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(changeSort))
    }
    
    private func setupView() {
        
        setupNavBar()
        
        monsterSearchController = UISearchController(searchResultsController: nil)
        
        monsterSearchController.searchResultsUpdater = self
        monsterSearchController.obscuresBackgroundDuringPresentation = false
        monsterSearchController.searchBar.placeholder = "Search Monsters"
        monsterSearchController.searchBar.barStyle = UIBarStyle.blackTranslucent

        if #available(iOS 11.0, *) {
            navigationItem.searchController = monsterSearchController
        } else {
            // Fallback on earlier versions
            self.tableView.tableHeaderView = monsterSearchController.searchBar
        }
        monsterSearchController.isActive = true
        monsterSearchController.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        self.monsterSearchController.delegate = self
        self.monsterSearchController.searchBar.delegate = self        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (isFiltering()) {
            return filteredMonsters.count
        }
        return goodMonsters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid) as! MonsterCell
        if(isFiltering()) {
            cell.monster = filteredMonsters[indexPath.row]
        }
        else {
            cell.monster = goodMonsters[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        // returns an NSManagedObject
        
        let currentMonster:NSManagedObject
        
        if isFiltering() {
            currentMonster = filteredMonsters[index]
        }
        else {
            currentMonster = goodMonsters[index]
        }
        
        let monsterVC = MonsterVC()
        monsterVC.monster = currentMonster
        
        let activeSkill = skills.filter({
            let skillID = $0.value(forKey: "skillID") as! Int
            let aSkill = currentMonster.value(forKey: "activeSkillID") as! Int
            
            if skillID == aSkill {
                return true
            }
            else {
                return false
            }
        }).first
        
        let leaderSkill = skills.filter({
            let skillID = $0.value(forKey: "skillID") as! Int
            let lSkill = currentMonster.value(forKey: "leaderSkillID") as! Int
            
            if skillID == lSkill {
                return true
            }
            else {
                return false
            }
        }).first
        
        monsterVC.activeSkill = activeSkill
        monsterVC.leaderSkill = leaderSkill
        
        
        //        let navCon = UINavigationController(rootViewController: monsterVC)
        //        self.present(navCon, animated: true, completion: nil)
        self.navigationController?.pushViewController(monsterVC, animated: true)
        
    }
    
}
