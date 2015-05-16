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
    init()
    {
        let texture = SKTexture(imageNamed: "bomber")
        super.init(movementSpeed: 100.0, canFire: true, fireRate: 5.0, bulletSpeed: 100.0, bulletDamage: 30.0, texture: texture, type: "bomber")
        self.name = "bomber"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}