//
//  DownloadSkillData.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/31/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData

func getSkillData() {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "SkillNA", in: managedContext)!
    
    if let url = URL(string: skill_api_link) {
        if let data = try? String(contentsOf: url) {
            let json = JSON(parseJSON: data)
            for skill in json.arrayValue {
                let item = NSManagedObject(entity: entity, insertInto: managedContext)
                item.setValue(skill["name"].stringValue, forKey: "name")
                item.setValue(skill["description"].stringValue, forKey: "desc")
                item.setValue(skill["skillID"].intValue, forKey: "skillID")
                item.setValue(skill["skillType"].stringValue, forKey: "skillType")
                item.setValue(skill["hp_mult"].floatValue, forKey: "hpMult")
                item.setValue(skill["atk_mult"].floatValue, forKey: "atkMult")
                item.setValue(skill["rcv_mult"].floatValue, forKey: "rcvMult")
                item.setValue(skill["dmg_reduction"].doubleValue, forKey: "dmgReduction")
                item.setValue(skill["c_skill_1"].intValue, forKey: "cSkill1")
                item.setValue(skill["c_skill_2"].intValue, forKey: "cSkill2")
                item.setValue(skill["c_skill_3"].intValue, forKey: "cSkill3")
                item.setValue(skill["skill_class"].stringValue, forKey: "skillClass")
                item.setValue(skill["levels"].intValue, forKey: "levels")
                item.setValue(skill["minTurns"].intValue, forKey: "minTurns")
                item.setValue(skill["maxTurns"].intValue, forKey: "maxTurns")
                item.setValue(skill["server"].stringValue, forKey: "server")
            }
        }
        do {
            try managedContext.save()
        }
        catch _ as NSError {
            print("Error saving skills in CoreData")
        }
    }
}

func getEnemySkillData() {
    
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate  else { return }
    let managedContext = appDelegate.persistentContainer.viewContext
    let entity = NSEntityDescription.entity(forEntityName: "EnemySkill", in: managedContext)!
    
    if let url = URL(string: enemy_skill_api_url) {
        if let data = try? String(contentsOf: url) {
            let json = JSON(parseJSON: data)
            for skill in json.arrayValue {
                let item = NSManagedObject(entity: entity, insertInto: managedContext)
                item.setValue(skill["name"].stringValue, forKey: "name")
                item.setValue(skill["effect"].stringValue, forKey: "effect")
                item.setValue(skill["enemy_skill_id"].intValue, forKey: "enemy_skill_id")
            }
        }
        do {
            try managedContext.save()
        }
        catch _ as NSError {
            print("Error saving enemy skills in CoreData")
        }
    }
}

func getLiveSkillData() {
    
    let url = URL(string: skill_api_link)!
    
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
            skills = try JSONDecoder().decode([Skill].self, from: data)
        } catch let error as NSError{
            print(error)
        }
    }
    
    // execute the HTTP request
    task.resume()
}
