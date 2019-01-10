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
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

class MonsterTableController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    let cellid = "monsterid"
    var monster_url:String = "https://pad-db.com/api/monsters/na/"
    var portrait_url:String = "https://storage.googleapis.com/mirubot/padimages/na/portrait/"
    var full_url:String = "https://storage.googleapis.com/mirubot/padimages/na/full/"
    var monsters = [NSManagedObject]()
    var rawMonsters = [Monster]()
    var filteredMonsters = [NSManagedObject]()
    var monstersearch:UISearchController!
    
    struct Monster {
        var activeSkillID:Int?
        var ancestorID:Int?
        var attributeID:Int?
        var awakenings:[Int]?
        var cardID:Int?
        var cost:Int?
        var unevomat1:Int?
        var unevomat2:Int?
        var unevomat3:Int?
        var unevomat4:Int?
        var unevomat5:Int?
        var evomat1:Int?
        var evomat2:Int?
        var evomat3:Int?
        var evomat4:Int?
        var evomat5:Int?
        var maxATK:Int?
        var maxHP:Int?
        var maxRCV:Int?
        var minATK:Int?
        var minHP:Int?
        var minRCV:Int?
        var maxLevel:Int?
        var maxXP:Int?
        var name:String?
        var rarity:Int?
        var subAttributeID:Int?
        var superAwakenings:[Int]?
        var type1:Int?
        var type2:Int?
        var type3:Int?
        
        var portraitLink:String?
        var fullLink:String?
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Monsters"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        setupView()
//        fillMonsterData()
        
        tableView.register(MonsterCell.self, forCellReuseIdentifier: cellid)
        tableView.rowHeight = 70
        
        
        tableView.reloadData()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "MonsterNA")
        
        //3
        do {
            monsters = try managedContext.fetch(fetchRequest)
            monsters.reverse()
        } catch _ as NSError {
            print("Could not fetch.")
        }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid) as! MonsterCell
        if(isFiltering()) {
            cell.monster = filteredMonsters[indexPath.row]
        }
        else {
            cell.monster = monsters[indexPath.row]
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
            currentMonster = monsters[index]
        }
        
        let monsterVC = MonsterVC()
        monsterVC.monster = currentMonster
        
        let navCon = UINavigationController(rootViewController: monsterVC)
        
        self.present(navCon, animated: true, completion: nil)
        
    }
    
    private func fillMonsterData() {
        // Source: https://mrgott.com/swift-programing/33-rest-api-in-swift-4-using-urlsession-and-jsondecode
        // load the url
        
        if let url = URL(string: monster_url) {
            if let data = try? String(contentsOf: url) {
                let json = JSON(parseJSON: data)
                for card in json.arrayValue {
                    
                    let name = card["name"].stringValue
                    if !name.contains("?") && !name.contains("*") && !name.isEmpty && !name.contains("Alt.") {
                        var monster:Monster = Monster()
                        monster.activeSkillID = card["activeSkillID"].intValue
                        monster.ancestorID = card["ancestorID"].intValue
                        monster.attributeID = card["attributeID"].intValue
                        
                        let decoder = JSONDecoder()
                        let vals = try! decoder.decode([Int].self, from: card["awakenings_raw"].stringValue.data(using: .utf8)!)
                        monster.awakenings = vals
                
                        
                        monster.cardID = card["cardID"].intValue
                        monster.cost = card["cost"].intValue
                        monster.unevomat1 = card["unevomat1"].intValue
                        monster.unevomat2 = card["unevomat2"].intValue
                        monster.unevomat3 = card["unevomat3"].intValue
                        monster.unevomat4 = card["unevomat4"].intValue
                        monster.unevomat5 = card["unevomat5"].intValue
                        monster.evomat1 = card["evomat1"].intValue
                        monster.evomat2 = card["evomat2"].intValue
                        monster.evomat3 = card["evomat3"].intValue
                        monster.evomat4 = card["evomat4"].intValue
                        monster.evomat5 = card["evomat5"].intValue
                        monster.maxATK = card["maxATK"].intValue
                        monster.maxHP = card["maxHP"].intValue
                        monster.maxRCV = card["maxRCV"].intValue
                        monster.minATK = card["minATK"].intValue
                        monster.minHP = card["minHP"].intValue
                        monster.minRCV = card["minRCV"].intValue
                        monster.maxXP = card["maxXP"].intValue
                        monster.maxLevel = card["maxLevel"].intValue
                        monster.name = card["name"].stringValue
                        monster.rarity = card["rarity"].intValue
                        monster.subAttributeID = card["subAttributeID"].intValue
                        
                        
                        let vals2 = try! decoder.decode([Int].self, from: card["superAwakenings_raw"].stringValue.data(using: .utf8)!)
                        monster.superAwakenings = vals2
                        
                        monster.portraitLink = getPortraitURL(id: monster.cardID!)
                        monster.fullLink = getFullURL(id: monster.cardID!)
                        
                        rawMonsters.append(monster)
                        
                        
                        
                    }
                }
            }
        }
        
        
        
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MonsterNA", in: managedContext)!
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MonsterNA")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        
        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        } catch {
            print("There was an error deleting items.")
        }
        
        for monster in rawMonsters {
            let item = NSManagedObject(entity: entity, insertInto: managedContext)
            item.setValue(monster.activeSkillID, forKey: "activeSkillID")
            item.setValue(monster.ancestorID, forKey: "ancestorID")
            item.setValue(monster.attributeID, forKey: "attributeID")
            item.setValue(monster.awakenings, forKey: "awakenings")
            item.setValue(monster.cardID, forKey: "cardID")
            item.setValue(monster.cost, forKey: "cost")
            item.setValue(monster.evomat1, forKey: "evomat1")
            item.setValue(monster.evomat2, forKey: "evomat2")
            item.setValue(monster.evomat3, forKey: "evomat3")
            item.setValue(monster.evomat4, forKey: "evomat4")
            item.setValue(monster.evomat5, forKey: "evomat5")
            item.setValue(monster.unevomat1, forKey: "unevomat1")
            item.setValue(monster.unevomat2, forKey: "unevomat2")
            item.setValue(monster.unevomat3, forKey: "unevomat3")
            item.setValue(monster.unevomat4, forKey: "unevomat4")
            item.setValue(monster.unevomat5, forKey: "unevomat5")
            item.setValue(monster.maxATK, forKey: "maxATK")
            item.setValue(monster.maxHP, forKey: "maxHP")
            item.setValue(monster.maxRCV, forKey: "maxRCV")
            item.setValue(monster.minATK, forKey: "minATK")
            item.setValue(monster.minHP, forKey: "minHP")
            item.setValue(monster.minRCV, forKey: "minRCV")
            item.setValue(monster.maxLevel, forKey: "maxLevel")
            item.setValue(monster.maxXP, forKey: "maxXP")
            item.setValue(monster.name, forKey: "name")
            item.setValue(monster.rarity, forKey: "rarity")
            item.setValue(monster.subAttributeID, forKey: "subAttributeID")
            item.setValue(monster.superAwakenings, forKey: "superAwakenings")
            item.setValue(monster.portraitLink, forKey: "portraitURL")
            item.setValue(monster.fullLink, forKey: "fullURL")
            
            
            
            do {
                try managedContext.save()
                monsters.append(item)
            }
            catch _ as NSError {
                print("Error saving monster in CoreData")
            }
        }
    }
    
    
    
    
    // SEARCH CONTROLLER FUNCTIONS
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return monstersearch.searchBar.text?.isEmpty ?? true
    }
    
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMonsters = monsters.filter({
            let val = $0.value(forKey: "name") as! String
            if val.lowercased().contains(searchText.lowercased()){
                return true
            }
            else {
                return false
            }
        })
        tableView.reloadData()
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
    
    private func getPortraitURL(id:Int) -> String {
        return portrait_url + String(id) + ".png"
    }
    
    private func getFullURL(id:Int) -> String {
        return full_url + String(id) + ".png"
    }
    
}
