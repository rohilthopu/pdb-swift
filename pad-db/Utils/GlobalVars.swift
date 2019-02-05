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
var runUpdate = true

var versions = [NSManagedObject]()
var newVersions:[String: Int] = [:]


var monsters = [NSManagedObject]()
var skills = [NSManagedObject]()
var enemySkills = [NSManagedObject]()


var monsterIDList:[Int: Int] = [:]
var skillIDList:[Int: Int] = [:]


var rawMonsters = [Monster]()
var rawSkills = [Skill]()

var goodMonsters = [NSManagedObject]()

var users = [User]()

var goodSkills = [NSManagedObject]()

var dungeons = [NSManagedObject]()
var floors = [NSManagedObject]()

var currGroupNA = ""
var currGroupJP = ""
