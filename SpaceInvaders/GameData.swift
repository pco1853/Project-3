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

class GameData: NSObject, NSCoding {
    
    //option vars
    var controlScheme = "virtual"
    var soundEnabled = true
    
    //game vars
    var highScores: [Int] = []
    var newHighScore = false
    var score = 0
    var credits = 0
    var scoreImage: UIImage?
    
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
        super.init()
    }
    
    
    required init(coder aDecoder: NSCoder){
        self.soundEnabled = aDecoder.decodeBoolForKey("sound") as Bool
        self.controlScheme = aDecoder.decodeObjectForKey("controls") as NSString
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        println("\(__FUNCTION__) called")
        aCoder.encodeBool(soundEnabled, forKey: "sound")
        aCoder.encodeObject(controlScheme, forKey: "controls")
    }
    
    //Saves our game data whenever we change options
    func saveOptions() {
        NSUserDefaults.standardUserDefaults().setObject(gameData.controlScheme, forKey: "Controls")
        NSUserDefaults.standardUserDefaults().setObject(gameData.soundEnabled, forKey: "Sound")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    //saves score everytime you die
    func saveScores() {
        NSUserDefaults.standardUserDefaults().setObject(gameData.highScores, forKey: "HighScores")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    //filters the top scores
    func filterHighScores(score: Int) {
        newHighScore = false
        
        //if no highscores then add player score
        if(highScores.count == 0 && score != 0)
        {
            highScores.append(score)
            newHighScore = true
        }
            //if one highscore check against the highscore and add if higher
        else if( highScores.count == 1)
        {
            if(score > highScores[0])
            {
                var temp = highScores[0]
                highScores.append(temp)
                highScores[0] = score
                newHighScore = true
            }
            else
            {
                highScores.append(score)
                newHighScore = true
            }
        }
            //otherwise sort the highscores and filter out if more than 10 exist
        else
        {
            highScores.append(score)
            highScores.sort(>)
          
            if(highScores.count > 10)
            {
                highScores.removeAtIndex(10)
            }
            
            //detect if player got new highscore
            for( var i = 0; i < highScores.count; i++)
            {
                if(score >= highScores[i])
                {
                    newHighScore = true
                }
            }
        }
        
        saveScores()
    }
}

let gameData = GameData()

