//
//  UFO.swift
//  SpaceInvaders
//
//  Created by Student on 4/22/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class UFO: SKSpriteNode {
   
    override init()
    {
        let texture = SKTexture(imageNamed: "ufo")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        self.name = "ufo"
        self.physicsBody = SKPhysicsBody(texture: self.texture, size: self.size)
        self.physicsBody?.dynamic = true
        self.physicsBody?.usesPreciseCollisionDetection = false
        self.physicsBody?.categoryBitMask = CollisionCategories.UFO
        self.physicsBody?.contactTestBitMask = CollisionCategories.PlayerBullet | CollisionCategories.Player
        //self.physicsBody?.collisionBitMask = 0x0
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
