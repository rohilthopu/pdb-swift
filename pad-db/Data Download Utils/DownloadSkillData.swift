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
    
    if let data = Just.get(skills_list_api_hook).content {
        do {
            skills = try JSONDecoder().decode([SkillListItem].self, from: data)
        } catch let error as NSError {
            print(error)
        }
    }
}
