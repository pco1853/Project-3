//
//  EnemyBullet.swift
//  SpaceInvaders
//
//  Created by Student on 5/14/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class EnemyBullet: Bullet {
    
    override init(imageName: String) {
        super.init(imageName: imageName)
        
        //set collision physics
        self.physicsBody?.categoryBitMask = CollisionCategories.EnemyBullet
        self.physicsBody?.contactTestBitMask = CollisionCategories.Player
        self.physicsBody?.collisionBitMask = 0x0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}