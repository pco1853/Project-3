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
    var isDead = false
    var engineParticle: SKEmitterNode!
    var harvester: Harvester!
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
        let texture = SKTexture(imageNamed: gameData.playerShip)
        super.init(
            health: gameData.playerHealth,
            movementSpeed: gameData.playerMovementSpeed,
            canFire: true,
            fireRate: gameData.playerFireRate,
            bulletSpeed: gameData.playerBulletSpeed,
            bulletDamage: gameData.playerBulletDamage,
            texture: texture,
            lockedPosition: false
        )
        
        //add shadow
        /*
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
        */
        
        //TODO: add engine
        
        //add engine particle
        self.engineParticle = SKEmitterNode(fileNamed: "Fire")
        self.engineParticle.position = CGPointMake(self.position.x, self.position.y - self.size.height / 2)
        self.engineParticle.zPosition = self.zEngineParticle
        self.addChild(self.engineParticle)
        
        //TODO: add guns
        
        //TODO: add harvester
        /*
        self.harvester = Harvester(length: 5)
        self.harvester.zPosition = self.zHarvester
        self.addChild(self.harvester)
        */
        
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
            
            let b1 = PlayerBullet(imageName: "bullet_player")
            b1.position.x = self.position.x - 12.0
            b1.position.y = self.position.y + 2.0 //+ self.size.height / 2
            b1.zPosition = self.zBullets
            b1.name = "playerBullet"
            
            let b2 = PlayerBullet(imageName: "bullet_player")
            b2.position.x = self.position.x + 12.0
            b2.position.y = self.position.y + 2.0 //+ self.size.height / 2
            b2.zPosition = self.zBullets
            b2.name = "playerBullet"
            
            scene.addChild(b1)
            scene.addChild(b2)
            
            let waitToEnableFire = SKAction.waitForDuration(self.fireRate)
            runAction(waitToEnableFire, completion: { self.canFire = true })
            
            audioManager.playSoundEffect("bullet_player.m4a", node: self)
        }
    }
    
    func fireHarvester() {
        if (self.canHarvest) {
            self.canHarvest = false
            self.harvester.fire()
        }
    }
    
    func firePowerup() {
        //if (self.powerup != nil) {
            //TODO:
        //}
    }
    
    func setEngineParticle() {
        var x = self.physicsBody?.velocity.dx
        self.engineParticle.xAcceleration = -x!
        
        var y = self.physicsBody?.velocity.dy
        self.engineParticle.yAcceleration = -y!
    }
    
    func takeDamage(damage: CGFloat, scene: SKScene) {
        if (!self.invincible) {
            self.health -= damage
            
            if (self.health <= 0) {
                self.health = 0
                explode(scene)
            }
            else {
                turnInvincible()
            }
        }
    }
    
    func turnInvincible(){ //makes player flash and become invincible briefly after being hurt
        self.invincible = true
        
        let fadeOut = SKAction.fadeOutWithDuration(0.1)
        let fadeIn = SKAction.fadeInWithDuration(0.1)
        let fadeOutIn = SKAction.sequence([fadeOut, fadeIn])
        let fadeOutInRepeat = SKAction.repeatAction(fadeOutIn, count: 3)
        self.runAction(fadeOutInRepeat, completion: { self.invincible = false })
    }
    
    func explode(scene: SKScene) {
        if (!self.isDead) {
            self.isDead = true
            self.alpha = 0
            //don't want to remove from parent because it breaks a million things and makes player nil
        
            let explosion = Explosion(type: "PlayerExplosion", duration: 2.0, x: self.position.x, y: self.position.y)
            scene.addChild(explosion)
            audioManager.playSoundEffect("ship_playerExplosion.m4a", node: self)
        }
    }
    
}
