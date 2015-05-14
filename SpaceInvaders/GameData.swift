//
//  GameData.swift
//  SpaceInvaders
//
//  Created by Student on 5/5/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation

class GameData: NSCoder {
    
    var controlScheme: String = "virtual"
    var soundEnabled: Bool = true
    
    override init() {
        //TODO: set vars from loaded file
    }
    
    func encodeWithCoder(aCoder: NSCoder){
        aCoder.encodeObject(gameData, forKey: "gameData")
        aCoder.encodeBool(soundEnabled, forKey: "sound")
        aCoder.encodeObject(controlScheme, forKey: "controls")
    }
    
    required init?(coder aDecoder: NSCoder) {
    }

    
}

var gameData = GameData()