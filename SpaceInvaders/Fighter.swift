//
//  Fighter.swift
//  SpaceInvaders
//
//  Created by Jason  on 5/13/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation
import SpriteKit

class Fighter: Enemy
{
    //draw order
    let zShip: CGFloat = 0
    let zBullets: CGFloat = -1
    let zGuns: CGFloat = -2
    let zEngine: CGFloat = -3
    let zEngineParticle: CGFloat = -4
    let zShadow: CGFloat = -5
    
    init()
    {
        let texture = SKTexture(imageNamed: "ufo")
        super.init(movementSpeed: 160.0, canFire: true, fireRate: 0.5, bulletSpeed: 600.0, bulletDamage: 10.0, texture: texture)
        self.name = "fighter"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    override func fireBullet(scene: SKScene)
    {
        let b1 = EnemyBullet(imageName: "laser")
        b1.position.x = self.position.x - 12.0
        b1.position.y = self.position.y + 2.0 //+ self.size.height / 2
        b1.zPosition = self.zBullets
        
        let b2 = EnemyBullet(imageName: "laser")
        b2.position.x = self.position.x + 12.0
        b2.position.y = self.position.y + 2.0 //+ self.size.height / 2
        b2.zPosition = self.zBullets
        
        self.bullets.append(b1)
        self.bullets.append(b2)
        scene.addChild(b1)
        scene.addChild(b2)
    }
}