//
//  Ship.swift
//  Harvester
//
//  Created by Student on 5/5/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class Ship: SKSpriteNode {
    
    var health: CGFloat = 100.0
    var movementSpeed: CGFloat = 200.0
    var canFire: Bool = true
    var fireRate: NSTimeInterval = 0.5
    var bulletSpeed: CGFloat = 500.0
    var bulletDamage: CGFloat = 10.0
    var bullets: [Bullet] = []
    
    init(health: CGFloat, movementSpeed: CGFloat, canFire: Bool, fireRate: NSTimeInterval, bulletSpeed: CGFloat, bulletDamage: CGFloat, texture: SKTexture) {
        self.health = health
        self.movementSpeed = movementSpeed
        self.canFire = canFire
        self.fireRate = fireRate
        self.bulletSpeed = bulletSpeed
        
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}