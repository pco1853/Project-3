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
    var lockedPosition: Bool = false
    
    init(health: CGFloat, movementSpeed: CGFloat, canFire: Bool, fireRate: NSTimeInterval, bulletSpeed: CGFloat, bulletDamage: CGFloat, texture: SKTexture, lockedPosition: Bool) {
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        
        //physics
        self.physicsBody = SKPhysicsBody(texture: self.texture, size: self.size)
        self.physicsBody?.dynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = false
        
        //custom vars
        self.health = health
        self.movementSpeed = movementSpeed
        self.canFire = canFire
        self.fireRate = fireRate
        self.bulletSpeed = bulletSpeed
        self.lockedPosition = lockedPosition
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setVelocity(#x: CGFloat, y: CGFloat, dt: CGFloat) {
        self.physicsBody?.velocity = CGVector(dx: x * dt * 100, dy: y * dt * 100)
    }
    
    func setVelocityFromAcceleration(#accelX: CGFloat, accelY: CGFloat, dt: CGFloat) {
        self.physicsBody?.velocity = CGVector(
            dx: self.movementSpeed * accelX * dt * 100,
            dy: self.movementSpeed * accelY * dt * 100
        )
    }

}