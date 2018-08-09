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
        var name:String
        init() {
            self.name = ""
        }
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
            cell.textLabel!.text = filteredMonsters[indexPath.row].name
        }
        else {
            cell.textLabel!.text = monsters[indexPath.row].name
            
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
                    if !card["name"].stringValue.contains("?") && !card["name"].stringValue.contains("*") {
                        var monster:Monster = Monster()
                        monster.name = card["name"].stringValue
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
        
        filteredMonsters = monsters.filter({$0.name.lowercased().contains(searchText.lowercased())})
        
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
