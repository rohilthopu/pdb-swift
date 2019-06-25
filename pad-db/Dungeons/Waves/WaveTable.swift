//
//  DungeonWaveTable.swift
//  pad-db
//
//  Created by Rohil Thopu on 2/22/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import UIKit
import SwiftyJSON
import CoreData

class WaveTable: UITableViewController {
    
    var floor:Floor?
    
    let cellid = "wavecell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(WaveCell.self, forCellReuseIdentifier: cellid)
        self.tableView.rowHeight = 100
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let floor = floor {
            return floor.waves
        } else {
            return 0
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! WaveCell
        cell.waveNumber = indexPath.row + 1
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let floor = floor {
            let floorVC = EncounterView()
            floorVC.dungeonFloor = floor
            floorVC.waveNumber = indexPath.row + 1
            floorVC.navigationItem.title = "Wave \(indexPath.row + 1)"
            self.navigationController?.pushViewController(floorVC, animated: true)
        }
    }
    
    
}
