//
//  Kamikazee.swift
//  SpaceInvaders
//
//  Created by Student on 5/15/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation
import SpriteKit

class Kamikaze: Enemy {
    
    init(lockedPosition: Bool) {
        //set vars
        let texture = SKTexture(imageNamed: "ship_kamikaze")
        super.init(
            health: 75.0,
            movementSpeed: 100.0,
            canFire: false,
            fireRate: 0.0,
            bulletSpeed: 0.0,
            bulletDamage: 0.0,
            texture: texture,
            lockedPosition: lockedPosition
        )
        
        self.name = "kamikaze"
        
        //enable precise detection
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fire() {
        if (!self.canFire) {
            self.canFire = true
            self.movementSpeed = 700.0
        
            audioManager.playSoundEffect("ship_kamikazeLock.m4a", node: self)
        }
    }
    
}