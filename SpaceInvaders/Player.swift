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
    var canHarvest = true
    var invincible = false
    //var powerup: Powerup! //TODO: implement powerups
    
    let zShip: CGFloat = 0
    let zHarvester: CGFloat = -1
    let zBullets: CGFloat = -2
    let zGuns: CGFloat = -3
    let zEngine: CGFloat = -4
    let zEngineParticle: CGFloat = -5
    let zShadow: CGFloat = -6
    
    //MARK: - Initialization -
    init() {
        //load player vars
        let playerShip = SKTexture(imageNamed: gameData.playerShip)
        super.init(health: gameData.playerHealth,
            movementSpeed: gameData.playerMovementSpeed,
                  canFire: true,
                 fireRate: gameData.playerFireRate,
              bulletSpeed: gameData.playerBulletSpeed,
             bulletDamage: gameData.playerBulletDamage,
                  texture: playerShip)
        
        //add shadow
        let shadowOffsetX: CGFloat = 10.0
        let shadowOffsetY: CGFloat = 10.0
        let shadow = SKSpriteNode(texture: self.texture)
        shadow.size = CGSizeMake(shadow.size.width + shadowOffsetX, shadow.size.height + shadowOffsetY)
        shadow.color = SKColor.blackColor()
        shadow.colorBlendFactor = 1.0;
        shadow.alpha = 0.5;
        let shadowEffect = SKEffectNode()
        let shadowEffectBlur = CIFilter(name: "CIGaussianBlur", withInputParameters: ["inputRadius": 5.0])
        shadowEffect.filter = shadowEffectBlur
        shadowEffect.zPosition = self.zShadow
        shadowEffect.addChild(shadow)
        self.addChild(shadowEffect)
        
        //TODO: add engine
        
        //add engine particle
        let engineParticle = SKEmitterNode(fileNamed: "Fire")
        engineParticle.position = CGPointMake(self.position.x, self.position.y - self.size.height / 2)
        engineParticle.zPosition = self.zEngineParticle
        self.addChild(engineParticle)
        
        //TODO: add guns
        
        //TODO: add harvester
        
        //set collision physics
        self.physicsBody?.categoryBitMask = CollisionCategories.Player
        self.physicsBody?.contactTestBitMask = CollisionCategories.Enemy | CollisionCategories.EnemyBullet
        self.physicsBody?.collisionBitMask = 0x0
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
        if (self.canHarvest) {
            //TODO:
        }
    }
    
    func firePowerup() {
        //if (self.powerup != nil) {
            //TODO:
        //}
    }
    
    func takeDamage(damage: CGFloat) {
        if (!self.invincible) {
            self.health -= damage
            turnInvincible()
        }
    }
    
    func turnInvincible(){ //makes player flash and become invincible for 1 sec after being hit
        self.invincible = true
        
        let fadeOut = SKAction.fadeOutWithDuration(0.1)
        let fadeIn = SKAction.fadeInWithDuration(0.1)
        let fadeOutIn = SKAction.sequence([fadeOut, fadeIn])
        let fadeOutInRepeat = SKAction.repeatAction(fadeOutIn, count: 5)
        runAction(fadeOutInRepeat, completion: { self.invincible = false })
    }
    
}
