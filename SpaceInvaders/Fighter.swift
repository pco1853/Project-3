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
    
    init()
    {
        let texture = SKTexture(imageNamed: "ufo")
        super.init(movementSpeed: 160.0, canFire: true, fireRate: 2.0, bulletSpeed: 400.0, bulletDamage: 10.0, texture: texture, type: "fighter")
        self.name = "fighter"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}