//
//  GuerrillaTableViewController.swift
//  pad-db
//
//  Created by Rohil Thopu on 12/19/18.
//  Copyright © 2018 Rohil Thopu. All rights reserved.
//

import UIKit
import SwiftyJSON


class GuerrillaTableViewController: UITableViewController {
    
    let cellid = "guerrillacell"
    
    struct Guerrilla {
        var name:String?
        var startTime:String?
        var endTime:String?
        var startSecs:Float?
        var endSecs:Float?
        var server:String?
        var group:String?
    }

    var dungeons = [Guerrilla]()

    override func viewDidLoad() {
        super.viewDidLoad()
                
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor.gray
        navigationItem.title = "Calendar"

        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        self.tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadGuerrilla()
    }
    
    private func loadGuerrilla() {
        let url = "https://www.pad-db.com/api/guerrilla"
        
        if let url = URL(string: url) {
            if let data = try? String(contentsOf: url) {
                let json = JSON(parseJSON: data)
                for item in json.arrayValue {
                    var dungeon:Guerrilla = Guerrilla()
                    dungeon.name = item["name"].stringValue
                    dungeons.append(dungeon)
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dungeons.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)

        cell.textLabel!.text = dungeons[indexPath.row].name!
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
