//
//  Explosion.swift
//  SpaceInvaders
//
//  Created by Student on 5/18/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class Explosion: SKSpriteNode {
    
    var particle: SKEmitterNode!
    var timer: NSTimeInterval! = 1.0
    
    init(type: String, duration: NSTimeInterval, x: CGFloat, y: CGFloat) {
        super.init(texture: nil, color: SKColor.clearColor(), size: CGSize(width: 100.0, height: 100.0))
        
        self.particle = SKEmitterNode(fileNamed: type)
        //self.particle.zPosition = -1000
        self.timer = duration
        self.position.x = x
        self.position.y = y
        
        self.addChild(self.particle)
        
        self.runAction(SKAction.waitForDuration(timer), completion: {
            self.runAction(SKAction.fadeOutWithDuration(0.25), completion: {
                    self.removeFromParent()
                })
        })
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}