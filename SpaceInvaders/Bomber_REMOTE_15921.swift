//
//  Bomber.swift
//  SpaceInvaders
//
//  Created by Student on 5/15/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation
import SpriteKit

class Bomber: Enemy
{
    init(lockedPosition: Bool) {
        //set vars
        let texture = SKTexture(imageNamed: "ship_bomber")
        super.init(
            health: 75.0,
            movementSpeed: 50.0,
            canFire: false,
            fireRate: 5.0,
            bulletSpeed: 200.0,
            bulletDamage: 25.0,
            texture: texture,
            lockedPosition: lockedPosition
        )
        
        self.name = "bomber"
        
        //determine fire delay
        let rand = NSTimeInterval(arc4random_uniform(UInt32(self.fireRate)))
        let waitToEnableFire = SKAction.waitForDuration(rand)
        self.runAction(waitToEnableFire, completion: { self.canFire = true })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fireBomb(scene: SKScene) {
        if (self.canFire) {
            self.canFire = false
            
            let b = EnemyBullet(imageName: "bullet_bomb")
            b.position.x = self.position.x
            b.position.y = self.position.y + 2.0
            b.zPosition = self.zBullets
            b.name = "enemyBomb"
            
            scene.addChild(b)
            
            let waitToEnableFire = SKAction.waitForDuration(self.fireRate)
            self.runAction(waitToEnableFire, completion: { self.canFire = true })
        
            audioManager.playSoundEffect("bullet_enemy.mp3", node: self)
        }
    }
    
}