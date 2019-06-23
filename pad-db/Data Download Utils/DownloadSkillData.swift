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
import Just

func getLiveSkillData() {
    
    if let data = Just.get(skill_api_link).content {
        do {
            skills = try JSONDecoder().decode([Skill].self, from: data)
        } catch let error as NSError {
            print(error)
        }
    }
}
