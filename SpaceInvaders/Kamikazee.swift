//
//  Kamikazee.swift
//  SpaceInvaders
//
//  Created by Student on 5/15/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation
import SpriteKit

class Kamikazee: Enemy
{

    
    init()
    {
        let texture = SKTexture(imageNamed: "Kamikazee")
        super.init(movementSpeed: 70.0, canFire: false, fireRate: 0.0, bulletSpeed: 0.0, bulletDamage: 0.0, texture: texture, type: "kamikazee")
        self.name = "kamikazee"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}