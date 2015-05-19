//
//  EnemyWaves.swift
//  SpaceInvaders
//
//  Created by Student on 5/18/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class EnemyWaves:SKSpriteNode{
    
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor.clearColor(), size: size)
        
        self.size = size
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setNewWave(wavesCleared: Int, index:Int)-> [Enemy] {
        
        //all easy waves
        if(wavesCleared <= 5)
        {
            if(index == 0)
            {
                //easy wave 1
                var easy1: [Enemy] = []
                var e1Fighter = createEnemy("fighter", xpos: size.width / 2 - 100, ypos: self.size.height - 50, moving: true)
                var e1Fighter1 = createEnemy("fighter", xpos: size.width / 2 + 100, ypos: self.size.height - 50, moving: true)
                var e1Kamikaze = createEnemy("kamikaze", xpos: size.width / 2 - 200, ypos: self.size.height - 200, moving: false)
                var e1Kamikaze1 = createEnemy("kamikaze", xpos: size.width / 2 + 200, ypos: self.size.height - 200, moving: false)
                easy1.append(e1Fighter)
                easy1.append(e1Fighter1)
                easy1.append(e1Kamikaze)
                easy1.append(e1Kamikaze1)
                
                return easy1
            }
            else if(index == 1)
            {
                //easy wave 2
                var easy2: [Enemy] = []
                var e2Kamikaze = createEnemy("kamikaze", xpos: size.width / 2 - 300, ypos: self.size.height - 50, moving: true)
                var e2Fighter = createEnemy("fighter", xpos: size.width / 2 - 275, ypos: self.size.height - 200, moving: false)
                var e2Fighter1 = createEnemy("fighter", xpos: size.width / 2 + 275, ypos: self.size.height - 200, moving: false)
                var e2Fighter2 = createEnemy("fighter", xpos: size.width / 2 - 50, ypos: self.size.height - 300, moving: true)
                var e2Fighter3 = createEnemy("fighter", xpos: size.width / 2 + 50, ypos: self.size.height - 300, moving: true)
                easy2.append(e2Kamikaze)
                easy2.append(e2Fighter)
                easy2.append(e2Fighter1)
                easy2.append(e2Fighter2)
                easy2.append(e2Fighter3)
                
                return easy2
            }
            else if(index == 2)
            {
                //easy wave 3
                var easy3: [Enemy] = []
                var e3Fighter = createEnemy("fighter", xpos: size.width / 2, ypos: self.size.height - 50, moving: true)
                var e3Fighter1 = createEnemy("fighter", xpos: size.width / 2, ypos: self.size.height - 150, moving: false)
                var e3Fighter2 = createEnemy("fighter", xpos: size.width / 2 - 70, ypos: self.size.height - 200, moving: false)
                var e3Fighter3 = createEnemy("fighter", xpos: size.width / 2 + 70, ypos: self.size.height - 200, moving: false)
                easy3.append(e3Fighter)
                easy3.append(e3Fighter1)
                easy3.append(e3Fighter2)
                easy3.append(e3Fighter3)
                
                return easy3
            }
            else
            {
                var empty:[Enemy] = []
                return empty
            }
        }
            //all medium waves
        else if(wavesCleared >= 6 && wavesCleared <= 11)
        {
            if(index == 0)
            {
                //medium wave 1
                var medium1: [Enemy] = []
                var m1Fighter = createEnemy("fighter", xpos: size.width / 2, ypos: self.size.height - 50, moving: true)
                var m1Fighter1 = createEnemy("fighter", xpos: size.width / 2 - 150, ypos: self.size.height - 50, moving: true)
                var m1Fighter2 = createEnemy("fighter", xpos: size.width / 2 + 150, ypos: self.size.height - 50, moving: true)
                var m1Fighter3 = createEnemy("fighter", xpos: size.width / 2 - 100, ypos: self.size.height - 200, moving: true)
                var m1Fighter4 = createEnemy("fighter", xpos: size.width / 2 + 100, ypos: self.size.height - 200, moving: true)
                medium1.append(m1Fighter)
                medium1.append(m1Fighter1)
                medium1.append(m1Fighter2)
                medium1.append(m1Fighter3)
                medium1.append(m1Fighter4)
                
                return medium1
            }
            else
            {
                var empty:[Enemy] = []
                return empty
            }
            
        }
            //all hard waves
        else if(wavesCleared >= 11)
        {
            var empty:[Enemy] = []
            return empty
        }
            //if no string is passed in then pass over an empty array
        else
        {
            var empty:[Enemy] = []
            return empty
        }
        
        
    }
    
    //quick helper fucntion to make enemys and place them on screen
    func createEnemy(type:String, xpos: CGFloat, ypos: CGFloat, moving: Bool) ->Enemy
    {
        var enemy:Enemy!
        if(type == "fighter")
        {
            enemy = Fighter(lockedPosition: !moving)
        }
        else if(type == "kamikaze")
        {
            enemy = Kamikaze(lockedPosition: !moving)
        }
        else if(type == "bomber")
        {
            enemy = Bomber(lockedPosition: !moving)
        }
        
        enemy.position.x = xpos
        enemy.position.y = ypos
        
        return enemy
    }
    
    
}
