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
    
    init(length: Int) {
        let texture = SKTexture(imageNamed: "harvester_claw")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        
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
        self.position.x = 0
        self.position.y = 0
        
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
    
    func updatePos() {
        self.position.x = 0
        self.position.y = 0
        
        for (var i = 0; i < self.links.count; i++) {
            let l = links[i]
            
            if (i == 0) {
                l.position.y = self.position.y - self.size.height / 2 - l.size.height / 2
            }
            else {
                l.position.y = self.links[i - 1].position.y - self.links[i - 1].size.height / 2 - l.size.height / 2
            }
        }
    }
    
    func fire() {
        let moveUp = SKAction.moveBy(CGVector(dx: 0, dy: self.length), duration: 0.25)
        let moveDown = SKAction.moveBy(CGVector(dx: 0, dy: -self.length), duration: 0.25)
        let sequence = SKAction.sequence([moveUp, moveDown])
        self.runAction(sequence)
    }

}