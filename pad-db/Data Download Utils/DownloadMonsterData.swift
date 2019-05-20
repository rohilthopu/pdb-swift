//
//  DownloadMonsterData.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/31/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

func getLiveMonsterData() {
    
    let url = URL(string: monster_url)!
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        
        // ensure there is no error for this HTTP response
        guard error == nil else {
            print ("error: \(error!)")
            return
        }
        
        // ensure there is data returned from this HTTP response
        guard let data = data else {
            print("No data")
            return
        }
        
        do {
            monsters = try JSONDecoder().decode([Monster].self, from: data)
        } catch let error as NSError{
            print(error)
        }
    }
    
    // execute the HTTP request
    task.resume()
}
