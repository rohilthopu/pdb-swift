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
var downloadData = true

var versions = [NSManagedObject]()
var newVersions:[String: Int] = [:]

var monsters = [MonsterListItem]()
var goodMonsters = [MonsterListItem]()
var skills = [Skill]()
var goodSkills = [Skill]()
var enemySkills = [NSManagedObject]()

var users = [User]()


var dungeons = [NSManagedObject]()
var floors = [NSManagedObject]()
var encounterSets = [NSManagedObject]()

var currGroupNA = ""
var currGroupJP = ""
var changeSettings = false

var naFilter = false
