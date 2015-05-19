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
        if(wavesCleared < 5)
        {
            if(index == 0)
            {
                //easy wave 1
                var easy1: [Enemy] = []
                var e1Fighter = createEnemy("fighter", xpos: size.width / 2 - 100, ypos: self.size.height + 350, moving: true)
                var e1Fighter1 = createEnemy("fighter", xpos: size.width / 2 + 100, ypos: self.size.height + 350, moving: true)
                var e1Kamikaze = createEnemy("kamikaze", xpos: size.width / 2 - 200, ypos: self.size.height + 200, moving: false)
                var e1Kamikaze1 = createEnemy("kamikaze", xpos: size.width / 2 + 200, ypos: self.size.height + 200, moving: false)
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
                var e2Kamikaze = createEnemy("kamikaze", xpos: size.width / 2 - 300, ypos: self.size.height + 350, moving: true)
                var e2Fighter = createEnemy("fighter", xpos: size.width / 2 - 275, ypos: self.size.height + 200, moving: false)
                var e2Fighter1 = createEnemy("fighter", xpos: size.width / 2 + 275, ypos: self.size.height + 200, moving: false)
                var e2Fighter2 = createEnemy("fighter", xpos: size.width / 2 - 50, ypos: self.size.height + 100, moving: true)
                var e2Fighter3 = createEnemy("fighter", xpos: size.width / 2 + 50, ypos: self.size.height + 100, moving: true)
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
                var e3Fighter = createEnemy("fighter", xpos: size.width / 2, ypos: self.size.height + 350, moving: true)
                var e3Fighter1 = createEnemy("fighter", xpos: size.width / 2, ypos: self.size.height + 250, moving: false)
                var e3Fighter2 = createEnemy("fighter", xpos: size.width / 2 - 100, ypos: self.size.height + 200, moving: false)
                var e3Fighter3 = createEnemy("fighter", xpos: size.width / 2 + 100, ypos: self.size.height + 200, moving: false)
                easy3.append(e3Fighter)
                easy3.append(e3Fighter1)
                easy3.append(e3Fighter2)
                easy3.append(e3Fighter3)
                
                return easy3
            }
            else if(index == 3)
            {
                //easy wave 4
                var easy4: [Enemy] = []
                var e4Fighter = createEnemy("fighter", xpos: size.width / 2 - 80, ypos: self.size.height + 200, moving: true)
                var e4Fighter1 = createEnemy("fighter", xpos: size.width / 2 - 80, ypos: self.size.height + 200, moving: true)
                var e4Fighter2 = createEnemy("fighter", xpos: size.width / 2 + 80, ypos: self.size.height + 100, moving: true)
                var e4Fighter3 = createEnemy("fighter", xpos: size.width / 2 + 80, ypos: self.size.height + 100, moving: true)
                var e4Bomber = createEnemy("bomber", xpos: size.width / 2, ypos: self.size.height + 300, moving: true)
                easy4.append(e4Fighter)
                easy4.append(e4Fighter1)
                easy4.append(e4Fighter2)
                easy4.append(e4Fighter3)
                easy4.append(e4Bomber)
                
                return easy4
            }
            else if(index == 4)
            {
                var easy5: [Enemy] = []
                var e5Fighter = createEnemy("fighter", xpos: size.width / 2 - 350, ypos: self.size.height + 200, moving: false)
                var e5Fighter1 = createEnemy("fighter", xpos: size.width / 2 + 350, ypos: self.size.height + 200, moving: false)
                var e5Fighter2 = createEnemy("fighter", xpos: size.width / 2, ypos: self.size.height + 200, moving: false)
                var e5Kamikaze = createEnemy("kamikaze", xpos: size.width / 2 - 200, ypos: self.size.height + 300, moving: false)
                var e5Kamikaze2 = createEnemy("kamikaze", xpos: size.width / 2 + 200, ypos: self.size.height + 300, moving: false)
                easy5.append(e5Fighter)
                easy5.append(e5Fighter1)
                easy5.append(e5Fighter2)
                easy5.append(e5Kamikaze)
                easy5.append(e5Kamikaze2)
                
                return easy5
                
            }
            else
            {
                var empty:[Enemy] = []
                return empty
            }
        }
            //all medium waves
        else if(wavesCleared >= 5 && wavesCleared <= 10)
        {
            if(index == 0)
            {
                //medium wave 1
                var medium1: [Enemy] = []
                var m1Fighter = createEnemy("fighter", xpos: size.width / 2, ypos: self.size.height + 350, moving: true)
                var m1Fighter1 = createEnemy("fighter", xpos: size.width / 2 - 150, ypos: self.size.height + 350, moving: true)
                var m1Fighter2 = createEnemy("fighter", xpos: size.width / 2 + 150, ypos: self.size.height + 350, moving: true)
                var m1Fighter3 = createEnemy("fighter", xpos: size.width / 2 - 100, ypos: self.size.height + 200, moving: true)
                var m1Fighter4 = createEnemy("fighter", xpos: size.width / 2 + 100, ypos: self.size.height + 200, moving: true)
                medium1.append(m1Fighter)
                medium1.append(m1Fighter1)
                medium1.append(m1Fighter2)
                medium1.append(m1Fighter3)
                medium1.append(m1Fighter4)
                
                return medium1
            }
            else if(index == 1)
            {
                //medium 2
                var medium2: [Enemy] = []
                var m2Bomber = createEnemy("bomber", xpos: size.width / 2 - 150, ypos: self.size.height + 300, moving: true)
                var m2Bomber1 = createEnemy("bomber", xpos: size.width / 2 + 100, ypos: self.size.height + 300, moving: true)
                var m2Fighter = createEnemy("fighter", xpos: size.width / 2 - 230, ypos: self.size.height + 100, moving: true)
                var m2Fighter1 = createEnemy("fighter", xpos: size.width / 2 + 230, ypos: self.size.height + 100, moving: true)
                var m2Fighter2 = createEnemy("fighter", xpos: size.width / 2 + 130, ypos: self.size.height + 400, moving: true)
                var m2Kamikaze = createEnemy("kamikaze", xpos: size.width / 2 - 70, ypos: self.size.height + 300, moving: false)
                medium2.append(m2Bomber)
                medium2.append(m2Bomber1)
                medium2.append(m2Fighter)
                medium2.append(m2Fighter1)
                medium2.append(m2Fighter2)
                medium2.append(m2Kamikaze)
                
                return medium2
                
            }
            else if(index == 2)
            {
                //medium 3
                var medium3: [Enemy] = []
                var m3Kamikaze = createEnemy("kamikaze", xpos: size.width / 2 - 270, ypos: self.size.height + 260, moving: false)
                var m3Kamikaze1 = createEnemy("kamikaze", xpos: size.width / 2 + 270, ypos: self.size.height + 260, moving: false)
                var m3Kamikaze2 = createEnemy("kamikaze", xpos: size.width / 2 + 130, ypos: self.size.height + 260, moving: false)
                var m3Kamikaze3 = createEnemy("kamikaze", xpos: size.width / 2 - 130, ypos: self.size.height + 260, moving: false)
                var m3Fighter = createEnemy("fighter", xpos: size.width/2, ypos: self.size.height + 390, moving: false)
                var m3Fighter1 = createEnemy("fighter", xpos: size.width/2 - 150, ypos: self.size.height + 420, moving: true)
                var m3Fighter2 = createEnemy("fighter", xpos: size.width/2 + 150, ypos: self.size.height + 420, moving: true)
                
                medium3.append(m3Kamikaze)
                medium3.append(m3Kamikaze1)
                medium3.append(m3Kamikaze2)
                medium3.append(m3Kamikaze3)
                medium3.append(m3Fighter)
                medium3.append(m3Fighter1)
                medium3.append(m3Fighter2)
                
                return medium3
            }
            else if(index == 3)
            {
                //medium 4
                var medium4: [Enemy] = []
                var m4Fighter = createEnemy("fighter", xpos: size.width / 2, ypos: self.size.height + 250, moving: true)
                var m4Fighter1 = createEnemy("fighter", xpos: size.width / 2 + 200, ypos: self.size.height + 250, moving: true)
                var m4Fighter2 = createEnemy("fighter", xpos: size.width / 2 - 200, ypos: self.size.height + 250, moving: true)
                var m4Fighter3 = createEnemy("fighter", xpos: size.width / 2 + 100, ypos: self.size.height + 150, moving: true)
                var m4Fighter4 = createEnemy("fighter", xpos: size.width / 2 - 100, ypos: self.size.height + 150, moving: true)
                var m4Bomber = createEnemy("bomber", xpos: size.width / 2 - 200, ypos: self.size.height + 350, moving: false)
                var m4Kamikaze = createEnemy("kamikaze", xpos: size.width / 2 + 200, ypos: self.size.height + 350, moving: false)
                medium4.append(m4Fighter)
                medium4.append(m4Fighter1)
                medium4.append(m4Fighter2)
                medium4.append(m4Fighter3)
                medium4.append(m4Fighter4)
                medium4.append(m4Bomber)
                medium4.append(m4Kamikaze)
                
                return medium4
            }
            else if(index == 4)
            {
                //medium 5
                var medium5: [Enemy] = []
                var m5Bomber = createEnemy("bomber", xpos: size.width / 2 + 200, ypos: self.size.height + 350, moving: true)
                var m5Bomber1 = createEnemy("bomber", xpos: size.width / 2 + 100, ypos: self.size.height + 300, moving: true)
                var m5Bomber2 = createEnemy("bomber", xpos: size.width / 2 , ypos: self.size.height + 270, moving: true)
                var m5Fighter = createEnemy("fighter", xpos: size.width / 2 - 175, ypos: self.size.height + 200, moving: false)
                var m5Fighter1 = createEnemy("fighter", xpos: size.width / 2 , ypos: self.size.height + 200, moving: false)
                var m5Fighter2 = createEnemy("fighter", xpos: size.width / 2 + 175 , ypos: self.size.height + 200, moving: false)
                
                medium5.append(m5Bomber)
                medium5.append(m5Bomber1)
                medium5.append(m5Bomber2)
                medium5.append(m5Fighter)
                medium5.append(m5Fighter1)
                medium5.append(m5Fighter2)
                
                return medium5
            }
            else
            {
                var empty:[Enemy] = []
                return empty
            }
            
        }
            //all hard waves
        else if(wavesCleared >= 10)
        {
            if(index == 0)
            {
                //hard1
                var hard1: [Enemy] = []
                var h1Fighter = createEnemy("fighter", xpos: size.width / 2, ypos: self.size.height + 380, moving: false)
                var h1Fighter1 = createEnemy("fighter", xpos: size.width / 2 + 300, ypos: self.size.height + 380, moving: false)
                var h1Fighter2 = createEnemy("fighter", xpos: size.width / 2 - 300, ypos: self.size.height + 380, moving: false)
                var h1Fighter3 = createEnemy("fighter", xpos: size.width / 2 + 50, ypos: self.size.height + 200, moving: true)
                var h1Fighter4 = createEnemy("fighter", xpos: size.width / 2 + 200, ypos: self.size.height + 200, moving: true)
                var h1Fighter5 = createEnemy("fighter", xpos: size.width / 2 - 150, ypos: self.size.height + 200, moving: true)
                var h1Fighter6 = createEnemy("fighter", xpos: size.width / 2 - 50, ypos: self.size.height + 300, moving: true)
                var h1Fighter7 = createEnemy("fighter", xpos: size.width / 2 + 150, ypos: self.size.height + 300, moving: true)
                var h1Fighter8 = createEnemy("fighter", xpos: size.width / 2 - 200, ypos: self.size.height + 300, moving: true)
                
                hard1.append(h1Fighter)
                hard1.append(h1Fighter1)
                hard1.append(h1Fighter2)
                hard1.append(h1Fighter3)
                hard1.append(h1Fighter4)
                hard1.append(h1Fighter5)
                hard1.append(h1Fighter6)
                hard1.append(h1Fighter7)
                hard1.append(h1Fighter8)
                
                return hard1
            }
            else if(index == 1)
            {
                var hard2: [Enemy] = []
                var h1Kamikaze = createEnemy("kamikaze", xpos: size.width / 2 - 150, ypos: self.size.height + 350, moving: true)
                var h1Kamikaze1 = createEnemy("kamikaze", xpos: size.width / 2 + 150, ypos: self.size.height + 350, moving: true)
                var h1Kamikaze2 = createEnemy("kamikaze", xpos: size.width / 2 - 75, ypos: self.size.height + 150, moving: false)
                var h1Kamikaze3 = createEnemy("kamikaze", xpos: size.width / 2 + 75, ypos: self.size.height + 150, moving: false)
                var h1Kamikaze4 = createEnemy("kamikaze", xpos: size.width / 2 - 250, ypos: self.size.height + 150, moving: false)
                var h1Kamikaze5 = createEnemy("kamikaze", xpos: size.width / 2 + 250, ypos: self.size.height + 150, moving: false)
                var h1Bomber = createEnemy("bomber", xpos: size.width / 2, ypos: self.size.height + 225, moving: true)
                
                hard2.append(h1Kamikaze)
                hard2.append(h1Kamikaze1)
                hard2.append(h1Kamikaze2)
                hard2.append(h1Kamikaze3)
                hard2.append(h1Kamikaze4)
                hard2.append(h1Kamikaze5)
                hard2.append(h1Bomber)
                return hard2
            }
            else if(index == 2)
            {
                var hard3: [Enemy] = []
                var h3Bomber = createEnemy("bomber", xpos: size.width / 2 - 350, ypos: self.size.height + 350, moving: false)
                var h3Bomber1 = createEnemy("bomber", xpos: size.width / 2 + 350, ypos: self.size.height + 350, moving: false)
                var h3Bomber2 = createEnemy("bomber", xpos: size.width / 2 - 100, ypos: self.size.height + 100, moving: true)
                var h3Bomber3 = createEnemy("bomber", xpos: size.width / 2 + 100, ypos: self.size.height + 100, moving: true)
                var h3Fighter = createEnemy("fighter", xpos: size.width/2, ypos: self.size.height + 350, moving: false)
                var h3Fighter2 = createEnemy("fighter", xpos: size.width/2 + 200, ypos: self.size.height + 200, moving: true)
                var h3Fighter3 = createEnemy("fighter", xpos: size.width/2 - 200, ypos: self.size.height + 200, moving: true)
                var h3Kamikaze = createEnemy("kamikaze", xpos: size.width / 2 + 150, ypos: self.size.height + 350, moving: false)
                var h3Kamikaze2 = createEnemy("kamikaze", xpos: size.width / 2 - 150, ypos: self.size.height + 350, moving: false)
                
                hard3.append(h3Bomber)
                hard3.append(h3Bomber1)
                hard3.append(h3Bomber2)
                hard3.append(h3Bomber3)
                hard3.append(h3Fighter)
                hard3.append(h3Fighter2)
                hard3.append(h3Fighter3)
                hard3.append(h3Kamikaze)
                hard3.append(h3Kamikaze2)
                
                return hard3
                
            }
            else if(index == 3)
            {
                var hard4: [Enemy] = []
                var h4Kamikaze = createEnemy("kamikaze", xpos: size.width / 2 - 340, ypos: self.size.height + 200, moving: false)
                var h4Kamikaze1 = createEnemy("kamikaze", xpos: size.width / 2 + 340, ypos: self.size.height + 200, moving: false)
                var h4Kamikaze2 = createEnemy("kamikaze", xpos: size.width / 2 - 200, ypos: self.size.height + 100, moving: true)
                var h4Kamikaze3 = createEnemy("kamikaze", xpos: size.width / 2 + 200, ypos: self.size.height + 100, moving: true)
                var h4Fighter = createEnemy("fighter", xpos: size.width / 2, ypos: self.size.height + 200, moving: false)
                var h4Fighter1 = createEnemy("fighter", xpos: size.width / 2 + 100, ypos: self.size.height + 350, moving: true)
                var h4Fighter2 = createEnemy("fighter", xpos: size.width / 2 - 100, ypos: self.size.height + 350, moving: true)
                var h4Bomber = createEnemy("bomber", xpos: size.width / 2, ypos: self.size.height + 350, moving: false)
                hard4.append(h4Kamikaze)
                hard4.append(h4Kamikaze1)
                hard4.append(h4Kamikaze2)
                hard4.append(h4Kamikaze3)
                hard4.append(h4Fighter)
                hard4.append(h4Fighter1)
                hard4.append(h4Fighter2)
                hard4.append(h4Bomber)
                
                return hard4
            }
            else if(index == 4)
            {
                var hard5: [Enemy] = []
                var h5Kamikaze = createEnemy("kamikaze", xpos: size.width / 2 - 140, ypos: self.size.height + 200, moving: false)
                var h5Kamikaze1 = createEnemy("kamikaze", xpos: size.width / 2 + 140, ypos: self.size.height + 200, moving: false)
                var h5Fighter = createEnemy("fighter", xpos: size.width / 2, ypos: self.size.height + 280, moving: true)
                var h5Fighter1 = createEnemy("fighter", xpos: size.width / 2 + 300, ypos: self.size.height + 280, moving: true)
                var h5Fighter2 = createEnemy("fighter", xpos: size.width / 2 - 300, ypos: self.size.height + 280, moving: true)
                var h5Bomber = createEnemy("bomber", xpos: size.width / 2, ypos: self.size.height + 350, moving: false)
                var h5Bomber1 = createEnemy("bomber", xpos: size.width / 2, ypos: self.size.height + 350, moving: true)
                var h5Bomber2 = createEnemy("bomber", xpos: size.width / 2, ypos: self.size.height + 350, moving: true)
                
                hard5.append(h5Kamikaze)
                hard5.append(h5Kamikaze1)
                hard5.append(h5Fighter)
                hard5.append(h5Fighter1)
                hard5.append(h5Fighter2)
                hard5.append(h5Bomber)
                hard5.append(h5Bomber1)
                hard5.append(h5Bomber2)
                
                return hard5
            }
            else
            {
                var empty:[Enemy] = []
                return empty
            }
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
