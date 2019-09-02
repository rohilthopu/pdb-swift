//
//  SkillTableVC.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/14/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit
import CoreData

extension SkillTable: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class SkillTable: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    let cellid = "skillcell"
    var filteredSkills = [SkillListItem]()
    var skillSearch:UISearchController!


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(SkillCell.self, forCellReuseIdentifier: cellid)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = 120
        setupNavBar()
        setupTableView()
        setupSearch()
        goodSkills = filterUsableSkills()
        sortSkillsDescending()
    }
    
    private func sortSkillsDescending() {
        goodSkills.sort{
            let first = $0.skillID
            let second = $1.skillID
            return first > second
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if goodSkills.count == 0 || changeSettings {
            goodSkills = filterUsableSkills()
            sortSkillsDescending()
        }
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if isFiltering() {
            return filteredSkills.count
        }
        return goodSkills.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! SkillCell
        
        if isFiltering() {
            let currID = filteredSkills[indexPath.row].skillID
            cell.skill = filteredSkills[indexPath.row]
            if let mon = getMonster(forSkillID: currID) {
                cell.monster = mon
            }
            return cell
        }

        let currID = goodSkills[indexPath.row].skillID
        cell.skill = goodSkills[indexPath.row]
        if let mon = getMonster(forSkillID: currID) {
            cell.monster = mon
        }
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        // returns an NSManagedObject
        
        let currentSkill:SkillListItem
        
        if isFiltering() {
            currentSkill = filteredSkills[index]
        }
        else {
            currentSkill = goodSkills[index]
        }
        let monsterVC = MonsterView()
        let skillID = currentSkill.skillID
        if let currentMonster = getMonster(forSkillID: skillID) {
        
            monsterVC.monster = getMonsterFromAPI(cardID: currentMonster.cardID)
            monsterVC.activeSkill = getSkill(forSkill: currentMonster.activeSkillID)
            monsterVC.leaderSkill = getSkill(forSkill: currentMonster.leaderSkillID)
            self.navigationController?.pushViewController(monsterVC, animated: true)
        }
    }

}
