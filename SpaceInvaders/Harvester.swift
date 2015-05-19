//
//  Harvester.swift
//  SpaceInvaders
//
//  Created by Student on 5/18/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation
import SpriteKit

class Harvester: SKSpriteNode {
    
    var links: [SKSpriteNode] = []
    var length: CGFloat!
    var movementSpeed: CGFloat!
    var isActive = false
    var isMovingUp = false
    var isMovingDown = false
    var colors: [UIColor] = []
    var colorIndex = 0
    
    init(length: Int) {
        let texture = SKTexture(imageNamed: "harvester_claw")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        
        self.movementSpeed = 600.0
        
        //set up links
        for (var i = 0; i < length; i++) {
            var l = SKSpriteNode(imageNamed: "harvester_link")
            
            if (i == 0) {
                l.position.y = self.position.y - self.size.height / 2 - l.size.height / 2
            }
            else {
                l.position.y = self.links[i - 1].position.y - self.links[i - 1].size.height / 2 - l.size.height / 2
            }
            self.links.append(l)
            self.addChild(l)
        }
        self.length = self.size.height + (self.links[0].size.height * CGFloat(self.links.count))
        
        setVisibility()
        generateColors()
        
        //physics
        self.physicsBody = SKPhysicsBody(texture: self.texture, size: self.size)
        self.physicsBody?.dynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = true
        self.physicsBody?.categoryBitMask = CollisionCategories.Harvester
        self.physicsBody?.contactTestBitMask = CollisionCategories.Enemy
        self.physicsBody?.collisionBitMask = 0x0
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fire() {
        self.isActive = true
        self.isMovingUp = true
        setColor()
    }
    
    func update(dt: CGFloat) {
        self.position.x = 0 //always center on player
        
        //position claw
        if (!self.isActive) {
            self.position.y = 0
        }
        else if (self.isMovingUp) {
            self.position.y += self.movementSpeed * dt
            
            if (self.position.y >= self.length) {
                self.position.y = self.length
                self.isMovingUp = false
                self.isMovingDown = true
            }
        }
        else if (self.isMovingDown) {
            self.position.y -= self.movementSpeed * dt
            
            if (self.position.y <= 0) {
                self.position.y = 0
                self.isMovingDown = false
                self.isActive = false
            }
        }
        
        setVisibility()
    }
    
    func setVisibility() {
        if (!self.isActive) {
            self.alpha = 0
        }
        else {
            self.alpha = 1.0
            
            for (var i = 0; i < self.links.count; i++) {
                var link = self.links[i]
                
                if (self.position.y >= (link.size.height * CGFloat(i)) + link.size.height / 2 + 5) {
                    link.alpha = 1.0
                }
                else {
                    link.alpha = 0
                }
            }
        }
    }
    
    func setColor() {
        if (self.isActive) {
            self.colorIndex++
            if (self.colorIndex >= self.colors.count) {
                self.colorIndex = 0
            }
            
            let colorize = SKAction.colorizeWithColor(self.colors[self.colorIndex], colorBlendFactor: 0.5, duration: 0.1)
            for link in self.links {
                link.runAction(colorize)
            }
            self.runAction(colorize, completion: {
                self.alpha = 1.0
                self.setColor()
            })
        }
    }
    
    func generateColors() {
        for (var i = 0; i < 20; i++) {
            let r = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
            let g = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
            let b = CGFloat(Float(arc4random()) / Float(UINT32_MAX))
            let a: CGFloat = 1.0
            
            let c = UIColor(red: r, green: g, blue: b, alpha: a)
            self.colors.append(c)
        }
    }

}