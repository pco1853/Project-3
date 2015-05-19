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
    
    func save(){
        //var pathToFile = FilePathInDocumentsDirectory("gameData.archive")
        //var success = NSKeyedArchiver.archiveRootObject(gameData, toFile: pathToFile)
        
        let saveData = NSKeyedArchiver.archivedDataWithRootObject(gameData);
      
        let path = DocumentsDirectory().stringByAppendingPathComponent("GameData.archive");
        
        println("Saved = \(saveData) to \(path)")
        
        saveData.writeToFile(path, atomically: true);
        
        //gameData = NSKeyedUnarchiver.unarchiveObjectWithFile(pathToFile)

    }
    
    func load() -> GameData?{
        var path = DocumentsDirectory().stringByAppendingPathComponent("GameData.archive");
        if let rawData = NSData(contentsOfFile: path){
        
        if let data = NSKeyedUnarchiver.unarchiveObjectWithData(rawData) as? GameData {
            println(data)
            return data
        }
        }
        else{
            println("nothing there")
        }
        
        return nil
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
    
    
}

let gameData = GameData()

