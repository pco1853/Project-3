//
//  Player.swift
//  Harvester
//
//  Created by Student on 4/21/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit
import CoreMotion

class Player: Ship {

    //MARK: - Variables -
    //draw order
    let zShip: CGFloat = 0
    let zHarvester: CGFloat = -1
    let zBullets: CGFloat = -2
    let zGuns: CGFloat = -3
    let zEngine: CGFloat = -4
    let zEngineParticle: CGFloat = -5
    let zShadow: CGFloat = -6
    
    var canHarvest = true
    var invincible = false
    //var powerup: Powerup! //TODO: implement powerups
    
    //MARK: - Initialization -
    init() { //TODO: load player data from GameData
        let texture = SKTexture(imageNamed: "Phoenix")
        super.init(health: 100.0, movementSpeed: 200.0, canFire: true, fireRate: 0.5, bulletSpeed: 600.0, bulletDamage: 25.0, texture: texture)
        
        //physics
        self.physicsBody = SKPhysicsBody(texture: self.texture, size: self.size)
        self.physicsBody?.dynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.usesPreciseCollisionDetection = false
        self.physicsBody?.categoryBitMask = CollisionCategories.Player
        self.physicsBody?.contactTestBitMask = CollisionCategories.Enemy | CollisionCategories.EnemyBullet
        self.physicsBody?.collisionBitMask = 0x0
        
        //shadow
        let shadowOffsetX: CGFloat = 10.0
        let shadowOffsetY: CGFloat = 10.0
        let shadow = SKSpriteNode(imageNamed: "Phoenix")
        shadow.size = CGSizeMake(shadow.size.width + shadowOffsetX, shadow.size.height + shadowOffsetY)
        shadow.color = SKColor.blackColor()
        shadow.colorBlendFactor = 1.0;
        shadow.alpha = 0.5;
        let shadowEffect = SKEffectNode()
        let shadowEffectBlur = CIFilter(name: "CIGaussianBlur", withInputParameters: ["inputRadius": 5.0])
        shadowEffect.filter = shadowEffectBlur
        shadowEffect.zPosition = self.zShadow
        shadowEffect.addChild(shadow)
        addChild(shadowEffect)
        
        //engine
        //TODO: customizable engine textures from shop
        //let engine: SKSpriteNode = SKSpriteNode()
        let engineParticle = SKEmitterNode(fileNamed: "Fire")
        engineParticle.position = CGPointMake(self.position.x, self.position.y - self.size.height / 2)
        engineParticle.zPosition = self.zEngineParticle
        addChild(engineParticle)
        
        //TODO: customizable gun texture
        
        //TODO: add Harvester claw child
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - METHODS -
    func fireBullet(scene: SKScene) {
        if (self.canFire) {
            self.canFire = false
            
            let b1 = PlayerBullet(imageName: "laser")
            b1.position.x = self.position.x - 12.0
            b1.position.y = self.position.y + 2.0 //+ self.size.height / 2
            b1.zPosition = self.zBullets
            
            let b2 = PlayerBullet(imageName: "laser")
            b2.position.x = self.position.x + 12.0
            b2.position.y = self.position.y + 2.0 //+ self.size.height / 2
            b2.zPosition = self.zBullets
            
            self.bullets.append(b1)
            self.bullets.append(b2)
            scene.addChild(b1)
            scene.addChild(b2)
            
            let waitToEnableFire = SKAction.waitForDuration(self.fireRate)
            runAction(waitToEnableFire, completion: { self.canFire = true })
        }
    }
    
    func fireHarvester() {
        if (canHarvest) {
            //TODO: implement harvester firing
        }
    }
    
    func takeDamage(damage: CGFloat) {
        if(!invincible) {
            self.health -= damage
            turnInvincible()
        }
    }
    
    func turnInvincible(){ //makes player flash and become invincible for 1 sec after being hit
        invincible = true
        
        let fadeOut = SKAction.fadeOutWithDuration(0.1)
        let fadeIn = SKAction.fadeInWithDuration(0.1)
        let fadeOutIn = SKAction.sequence([fadeOut, fadeIn])
        let fadeOutInRepeat = SKAction.repeatAction(fadeOutIn, count: 5)
        runAction(fadeOutInRepeat, completion: { self.invincible = false })
    }
}
