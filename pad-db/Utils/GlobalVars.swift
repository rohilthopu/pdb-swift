//
//  GlobalVars.swift
//  pad-db
//
//  Created by Rohil Thopu on 2/1/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit
import CoreData

var naDungeons = [Guerrilla]()
var jpDungeons = [Guerrilla]()

var allGuerrillaDungeons = [Guerrilla]()
var displayDungeons = [Guerrilla]()
var showingNA = true

var monsters = [MonsterListItem]()
var goodMonsters = [MonsterListItem]()
var skills = [SkillListItem]()
var goodSkills = [SkillListItem]()
var enemySkills = [NSManagedObject]()


var dungeons = [NSManagedObject]()
var floors = [NSManagedObject]()
var encounterSets = [NSManagedObject]()

var currGroupNA = ""
var currGroupJP = ""
var changeSettings = false

var naFilter = false
