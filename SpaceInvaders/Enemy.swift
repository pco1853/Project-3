//
//  Enemy.swift
//  Harvester
//
//  Created by Student on 5/5/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class Enemy: Ship {
    
    //MARK: - Variables -
    var hasPowerup: Bool = false
    var moveDirection:String?
    
    //draw order
    let zShip: CGFloat = 0
    let zBullets: CGFloat = -1
    let zGuns: CGFloat = -2
    let zEngine: CGFloat = -3
    let zEngineParticle: CGFloat = -4
    let zShadow: CGFloat = -5
    
    override init(health: CGFloat, movementSpeed: CGFloat, canFire: Bool, fireRate: NSTimeInterval, bulletSpeed: CGFloat, bulletDamage: CGFloat, texture: SKTexture) {
        //set vars
        super.init(
            health: health,
            movementSpeed:movementSpeed,
            canFire: canFire,
            fireRate: fireRate,
            bulletSpeed: bulletSpeed,
            bulletDamage: bulletDamage,
            texture: texture
        )
        
        //set collision phsyics
        self.physicsBody?.categoryBitMask = CollisionCategories.Enemy
        self.physicsBody?.contactTestBitMask = CollisionCategories.Player | CollisionCategories.PlayerBullet
        self.physicsBody?.collisionBitMask = 0x0
        
        //determine movement direction
        let rand = Int(arc4random_uniform(3))
        switch rand {
        case 0:
            self.moveDirection = "left"
        case 1:
            self.moveDirection = "right"
        default:
            self.moveDirection = "none"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func takeDamage(damage: CGFloat) {
        self.health -= damage
        
        if (self.health <= 0) {
            explode()
        }
        else {
            let fadeOut = SKAction.fadeOutWithDuration(0.1)
            let fadeIn = SKAction.fadeInWithDuration(0.1)
            let fadeOutIn = SKAction.sequence([fadeOut, fadeIn])
            let fadeOutInRepeat = SKAction.repeatAction(fadeOutIn, count: 5)
            runAction(fadeOutInRepeat)
        }
    }
    
    func explode() {
        //TODO: animate explosion
        self.removeFromParent()
        
        audioManager.playSoundEffect("ship_enemyExplosion.m4a", node: self)
    }

}
