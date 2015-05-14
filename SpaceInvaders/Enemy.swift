//
//  Enemy.swift
//  Harvester
//
//  Created by Student on 5/5/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class Enemy: SKSpriteNode
{
    
    //MARK: - Variables -
    var hasPowerup: Bool = false
    //var powerup: Powerup! //TODO: implement powerups
    var movementSpeed: CGFloat?
    var bulletSpeed: CGFloat?
    var bulletDamage: CGFloat = 10.0
    var bullets: [Bullet] = []
    var fireRate: NSTimeInterval = 0.5
    var canFire: Bool = true
    var moveDirection:String?
    var randomNumber:UInt32!
    
    init(movementSpeed: CGFloat, canFire: Bool, fireRate:NSTimeInterval, bulletSpeed: CGFloat, bulletDamage: CGFloat, texture: SKTexture)
    {
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        
        self.movementSpeed = movementSpeed
        self.bulletSpeed = bulletSpeed
        self.bulletDamage = bulletDamage
        self.canFire = canFire
        self.fireRate = fireRate
        
        self.physicsBody = SKPhysicsBody(texture: self.texture, size: self.size)
        self.physicsBody?.dynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = false
        self.physicsBody?.categoryBitMask = CollisionCategories.Enemy
        self.physicsBody?.contactTestBitMask = CollisionCategories.Player | CollisionCategories.PlayerBullet
        self.physicsBody?.collisionBitMask = 0x0
        
        //Sets up random number to determine if the nemey will go left or right off spawn
        randomNumber = arc4random_uniform(3 - 1) + 1
        
        if(randomNumber == 1)
        {
            self.moveDirection = "Right"
        }
        else if(randomNumber == 2)
        {
            self.moveDirection = "Left"
        }
    }
    
    func fireBullet(scene: SKScene)
    {
        if (self.canFire)
        {
            self.canFire = false
            let waitToEnableFire = SKAction.waitForDuration(self.fireRate)
            runAction(waitToEnableFire, completion: { self.canFire = true })
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
