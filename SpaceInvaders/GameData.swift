//
//  GameData.swift
//  SpaceInvaders
//
//  Created by Student on 5/5/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

class GameData: NSCoder {
    
    //option vars
    var controlScheme = "virtual"
    var soundEnabled = true
    
    //game vars
    var highScores: [Int] = []
    var score = 0
    var credits = 0
    
    //player vars
    var playerShip = "Phoenix"
    var playerGuns = ""
    var playerEngine = ""
    
    var playerHealth: CGFloat = 100.0
    var playerMovementSpeed: CGFloat = 200.0
    var playerFireRate: NSTimeInterval = 0.5
    var playerBulletSpeed: CGFloat = 500.0
    var playerBulletDamage: CGFloat = 20.0
    
    override init() {
        //TODO: set vars from loaded file
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(gameData, forKey: "gameData")
        aCoder.encodeBool(soundEnabled, forKey: "sound")
        aCoder.encodeObject(controlScheme, forKey: "controls")
    }
    
    required init?(coder aDecoder: NSCoder) {
    }

    
}

var gameData = GameData()