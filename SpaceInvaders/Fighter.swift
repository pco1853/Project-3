//
//  Fighter.swift
//  SpaceInvaders
//
//  Created by Jason  on 5/13/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation
import SpriteKit

class Fighter: Enemy {
    
    init(lockedPosition: Bool) {
        //set vars
        let texture = SKTexture(imageNamed: "ship_fighter")
        super.init(
            health: 40.0,
            movementSpeed: 100.0,
            canFire: false,
            fireRate: 2.0,
            bulletSpeed: 400.0,
            bulletDamage: 10.0,
            texture: texture,
            lockedPosition: lockedPosition
        )
        
        self.name = "fighter"
        
        //determine fire delay
        let rand = NSTimeInterval(arc4random_uniform(UInt32(self.fireRate * 2)))
        let waitToEnableFire = SKAction.waitForDuration(rand)
        self.runAction(waitToEnableFire, completion: { self.canFire = true })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fireBullet(scene: SKScene) {
        if (self.canFire) {
            self.canFire = false
            
            let b1 = EnemyBullet(imageName: "bullet_enemy")
            b1.position.x = self.position.x - 12.0
            b1.position.y = self.position.y + 2.0
            b1.zPosition = -1
            b1.name = "enemyBullet"
            
            let b2 = EnemyBullet(imageName: "bullet_enemy")
            b2.position.x = self.position.x + 12.0
            b2.position.y = self.position.y + 2.0
            b2.zPosition = -1
            b2.name = "enemyBullet"
            
            scene.addChild(b1)
            scene.addChild(b2)
            
            let rand = NSTimeInterval(arc4random_uniform(UInt32(self.fireRate * 4)))
            let waitToEnableFire = SKAction.waitForDuration(rand)
            self.runAction(waitToEnableFire, completion: { self.canFire = true })
            
            audioManager.playSoundEffect("bullet_enemy.mp3", node: self)
        }
    }

}