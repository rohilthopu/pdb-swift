//
//  structs.swift
//  pad-db
//
//  Created by Rohil Thopu on 1/31/19.
//  Copyright © 2019 Rohil Thopu. All rights reserved.
//

import Foundation
import UIKit

struct User {
    var user:String?
    var score:Int?
    var scoreUp:Bool?
    var scoreDown:Bool?
    var scoreDiff:Int?
}

struct Guerrilla {
    var name:String?
    var startTime:String?
    var endTime:String?
    var startSecs:Float?
    var endSecs:Float?
    var server:String?
    var group:String?
    var dungeonID:Int?
    var remainingTime:Double?
    var status:String?
    var imgID:Int?
    var imgLink:String?
}

