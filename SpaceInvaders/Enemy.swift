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
    var moveDirection:String?
    var finishedSpawningIn = false
    
    override init(health: CGFloat, movementSpeed: CGFloat, canFire: Bool, fireRate: NSTimeInterval, bulletSpeed: CGFloat, bulletDamage: CGFloat, texture: SKTexture, lockedPosition: Bool) {
        //set vars
        super.init(
            health: health,
            movementSpeed:movementSpeed,
            canFire: canFire,
            fireRate: fireRate,
            bulletSpeed: bulletSpeed,
            bulletDamage: bulletDamage,
            texture: texture,
            lockedPosition: lockedPosition
        )
        
        //set collision phsyics
        self.physicsBody?.categoryBitMask = CollisionCategories.Enemy
        self.physicsBody?.contactTestBitMask = CollisionCategories.Player | CollisionCategories.PlayerBullet
        self.physicsBody?.collisionBitMask = 0x0
        
        //determine movement direction
        if(self.lockedPosition) {
            self.moveDirection = "None"
        }
        else {
            let rand = Int(arc4random_uniform(2))
            switch rand {
            case 0:
                self.moveDirection = "left"
            case 1:
                self.moveDirection = "right"
            default:
                self.moveDirection = "right"
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func takeDamage(damage: CGFloat, scene: SKScene) {
        self.health -= damage
        
        if (self.health <= 0) {
            explode(scene)
        }
        else {
            let turnRed = SKAction.colorizeWithColor(SKColor.redColor(), colorBlendFactor: 1.0, duration: 0.1)
            let turnNormal = SKAction.colorizeWithColor(SKColor.whiteColor(), colorBlendFactor: 1.0, duration: 0.1)
            let flashRed = SKAction.sequence([turnRed, turnNormal])
            let flashRedRepeat = SKAction.repeatAction(flashRed, count: 3)
            self.runAction(flashRedRepeat, completion: { //catch error where ship sometimes disappears
                self.color = SKColor.whiteColor()
                self.colorBlendFactor = 1.0
                self.alpha = 1.0
            })
        }
    }
    
    func explode(scene: SKScene) {
        let explosion = Explosion(type: "EnemyExplosion", duration: 1.0, x: self.position.x, y: self.position.y)
        scene.addChild(explosion)
        audioManager.playSoundEffect("ship_enemyExplosion.m4a", node: self)
        
        self.removeFromParent()
    }

}
