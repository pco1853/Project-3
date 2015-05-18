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
    
    init() {
        //set vars
        let texture = SKTexture(imageNamed: "ship_fighter")
        super.init(
            health: 100.0,
            movementSpeed: 100.0,
            canFire: false,
            fireRate: 1.0,
            bulletSpeed: 400.0,
            bulletDamage: 10.0,
            texture: texture
        )
        
        self.name = "fighter"
        
        //determine fire delay
        let rand = NSTimeInterval(arc4random_uniform(UInt32(self.fireRate)))
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
            b1.zPosition = self.zBullets
            b1.name = "enemyBullet"
            
            let b2 = EnemyBullet(imageName: "bullet_enemy")
            b2.position.x = self.position.x + 12.0
            b2.position.y = self.position.y + 2.0
            b2.zPosition = self.zBullets
            b2.name = "enemyBullet"
            
            scene.addChild(b1)
            scene.addChild(b2)
            
            let waitToEnableFire = SKAction.waitForDuration(self.fireRate)
            self.runAction(waitToEnableFire, completion: { self.canFire = true })
            
            audioManager.playSoundEffect("bullet_enemy.mp3", node: self)
        }
    }

}