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
    var health: CGFloat!
    var movementSpeed: CGFloat!
    var canFire: Bool!
    var fireRate: NSTimeInterval!
    var bulletSpeed: CGFloat!
    var bulletDamage: CGFloat!
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