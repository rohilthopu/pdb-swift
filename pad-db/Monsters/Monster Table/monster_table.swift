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


extension MonsterTable: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForText(searchController.searchBar.text!)
    }
}

class MonsterTable: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    let cellid = "monsterid"
    
    
    var filteredMonsters = [MonsterListItem]()
    var monsterSearchController:UISearchController!
    
    var isDescendedSort:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupView()
        getLiveMonsterData()
        getLiveSkillData()
        getLiveDungeonData()
        filterGoodMonsters()

        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if goodMonsters.count == 0 || changeSettings {
            filterGoodMonsters()
            sortMonstersDescending()
        }
        self.tableView.reloadData()
    }
    
    private func filterGoodMonsters() {
        if naFilter {
            goodMonsters = monsters.filter{
                return $0.cardID < 100000 && $0.server == "NA"
            }
        } else {
            goodMonsters = monsters.filter{
                return $0.cardID < 100000
            }
        }
        sortMonstersDescending()
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
//        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.3285208941, blue: 0.5748849511, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "order")!.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: UIBarButtonItem.Style.plain, target: self, action: #selector(changeSort))
    }
    
    private func setupView() {
        
        setupNavBar()
        
        monsterSearchController = UISearchController(searchResultsController: nil)
        
        monsterSearchController.searchResultsUpdater = self
        monsterSearchController.obscuresBackgroundDuringPresentation = false
        monsterSearchController.searchBar.placeholder = "Search Monsters"
//        monsterSearchController.searchBar.barStyle = UIBarStyle.blackTranslucent

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
        
        let currentMonster:MonsterListItem
        
        if isFiltering() {
            currentMonster = filteredMonsters[index]
        }
        else {
            currentMonster = goodMonsters[index]
        }
        
        
        let monster = getMonsterFromAPI(cardID: currentMonster.cardID)
        
        if let monster = monster {
            let monsterVC = MonsterView(monster: monster)
            monsterVC.activeSkill = getSkill(forSkill: monster.activeSkillID)
            monsterVC.leaderSkill = getSkill(forSkill: monster.leaderSkillID)
            
            self.navigationController?.pushViewController(monsterVC, animated: true)
        }

        
    }
    
}
