//
//  SkillTableVC.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/14/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit
import CoreData

extension SkillTableVC: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}



class SkillTableVC: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    let cellid = "skillcell"
    var filteredSkills = [NSManagedObject]()
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
            let currID = filteredSkills[indexPath.row].value(forKey: "skillID") as! Int
            cell.skill = filteredSkills[indexPath.row]
            if let mon = getMonster(forSkillID: currID) {
                cell.monster = mon
            }
            return cell
        }

        let currID = goodSkills[indexPath.row].value(forKey: "skillID") as! Int
        cell.skill = goodSkills[indexPath.row]
        if let mon = getMonster(forSkillID: currID) {
            cell.monster = mon
        }
        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        // returns an NSManagedObject
        
        let currentSkill:NSManagedObject
        
        if isFiltering() {
            currentSkill = filteredSkills[index]
        }
        else {
            currentSkill = goodSkills[index]
        }
        let monsterVC = MonsterVC()
        let skillID = currentSkill.value(forKey: "skillID") as! Int
        if let currentMonster = getMonster(forSkillID: skillID) {
        
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
            self.navigationController?.pushViewController(monsterVC, animated: true)
        }
    }

}