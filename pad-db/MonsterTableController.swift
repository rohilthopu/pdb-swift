//
//  MonsterTableController.swift
//  pad-db
//
//  Created by Rohil Thopu on 8/9/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit
import SwiftyJSON

extension MonsterTableController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class MonsterTableController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    @IBOutlet var monstertable: UITableView!
    
    var monster_url:String = "https://storage.googleapis.com/mirubot/paddata/processed/na_cards.json"
    var monsters = [Monster]()
    var filteredMonsters = [Monster]()
    var monstersearch:UISearchController!
    
    struct Monster {
        var activeSkillID:Int?
        var ancestorID:Int?
        var attrID:Int?
        var cardID:Int?
        var cost:Int?
        var devoMat1:Int?
        var devoMat2:Int?
        var devoMat3:Int?
        var devoMat4:Int?
        var devoMat5:Int?
        var evoMat1:Int?
        var evoMat2:Int?
        var evoMat3:Int?
        var evoMat4:Int?
        var evoMat5:Int?
        var maxATK:Int?
        var maxHP:Int?
        var maxRCV:Int?
        var minATK:Int?
        var minHP:Int?
        var minRCV:Int?
        var name:String?
        var rarity:Int?
        var subAttrID:Int?
        var type1:Int?
        var type2:Int?
        var type3:Int?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "PAD DB"
        navigationController?.navigationBar.barTintColor = UIColor.gray
        setupView()
        fillMonsterData()
        self.monstertable.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    private func setupView() {
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = monstersearch
        } else {
            tableView.tableHeaderView = monstersearch.searchBar
        }
        
        monstersearch = UISearchController(searchResultsController: nil)
        
        monstersearch.searchResultsUpdater = self
        monstersearch.obscuresBackgroundDuringPresentation = false
        monstersearch.searchBar.placeholder = "Search Monsters"
        navigationItem.searchController = monstersearch
        monstersearch.isActive = true
        monstersearch.hidesNavigationBarDuringPresentation = false
        self.definesPresentationContext = true
        self.monstersearch.delegate = self
        self.monstersearch.searchBar.delegate = self
        self.extendedLayoutIncludesOpaqueBars = true
        
        
        self.monstertable.rowHeight = 85
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (isFiltering()) {
            return filteredMonsters.count
        }
        return monsters.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "monstercell")!
        if(isFiltering()) {
            cell.textLabel!.text = filteredMonsters[indexPath.row].name!
            cell.detailTextLabel!.text = String(filteredMonsters[indexPath.row].cardID!)
        }
        else {
            cell.textLabel!.text = monsters[indexPath.row].name!
            cell.detailTextLabel!.text = String(monsters[indexPath.row].cardID!)
        }
        return cell
    }
    
    private func fillMonsterData() {
        // Source: https://mrgott.com/swift-programing/33-rest-api-in-swift-4-using-urlsession-and-jsondecode
        // load the url
        if let url = URL(string: monster_url) {
            if let data = try? String(contentsOf: url) {
                let json = JSON(parseJSON: data)
                for item in json.arrayValue {
                    let card = item["card"]
                    if !card["name"].stringValue.contains("?") && !card["name"].stringValue.contains("*") && !card["name"].stringValue.isEmpty {
                        var monster:Monster = Monster()
                        monster.activeSkillID = card["active_skill_id"].intValue
                        monster.ancestorID = card["ancestory_id"].intValue
                        monster.attrID = card["attr_id"].intValue
                        monster.cardID = card["card_id"].intValue
                        monster.cost = card["cost"].intValue
                        monster.devoMat1 = card["un_evo_mat_1"].intValue
                        monster.devoMat2 = card["un_evo_mat_2"].intValue
                        monster.devoMat3 = card["un_evo_mat_3"].intValue
                        monster.devoMat4 = card["un_evo_mat_4"].intValue
                        monster.devoMat5 = card["un_evo_mat_5"].intValue
                        monster.evoMat1 = card["evo_mat_id_1"].intValue
                        monster.evoMat2 = card["evo_mat_id_2"].intValue
                        monster.evoMat3 = card["evo_mat_id_3"].intValue
                        monster.evoMat4 = card["evo_mat_id_4"].intValue
                        monster.evoMat5 = card["evo_mat_id_5"].intValue
                        monster.maxATK = card["max_atk"].intValue
                        monster.maxHP = card["max_hp"].intValue
                        monster.maxRCV = card["max_rcv"].intValue
                        monster.minATK = card["min_atk"].intValue
                        monster.minHP = card["min_hp"].intValue
                        monster.minRCV = card["min_rcv"].intValue
                        monster.name = card["name"].stringValue
                        monster.rarity = card["rarity"].intValue
                        monster.subAttrID = card["sub_attr_id"].intValue
                        monsters.append(monster)
                    }
                }
            }
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    // SEARCH CONTROLLER FUNCTIONS
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return monstersearch.searchBar.text?.isEmpty ?? true
    }
    
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        filteredMonsters = monsters.filter({$0.name!.lowercased().contains(searchText.lowercased())})
        
        monstertable.reloadData()
    }
    
    func isFiltering() -> Bool {
        return monstersearch.isActive && !searchBarIsEmpty()
    }
    
    
    
    //    Misc
    func uicolorFromHex(rgbValue:UInt32)->UIColor{
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/255.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/255.0
        let blue = CGFloat(rgbValue & 0xFF)/255.0
        
        return UIColor(red:red, green:green, blue:blue, alpha:1.0)
    }
    
}
