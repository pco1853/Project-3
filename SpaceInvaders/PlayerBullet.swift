//
//  PlayerBullet.swift
//  SpaceInvaders
//
//  Created by Student on 4/22/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class PlayerBullet: Bullet {
   
    override init(imageName: String){
        super.init(imageName: imageName)
        
        self.physicsBody = SKPhysicsBody(texture: self.texture, size: self.size)
        self.physicsBody?.dynamic = true
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = CollisionCategories.PlayerBullet
        self.physicsBody?.contactTestBitMask = CollisionCategories.Enemy
        self.physicsBody?.collisionBitMask = 0x0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
