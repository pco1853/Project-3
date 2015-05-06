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
    var invincible: Bool = false
    //var powerup: Powerup! //TODO: implement powerups
    
    let motionManager: CMMotionManager = CMMotionManager()
    var accelerationX: CGFloat = 0.0
    
    //MARK: - Initialization -
    init() {
        //TODO: load player data from GameData
        let texture = SKTexture(imageNamed: "Phoenix")
        super.init(health: 100.0, movementSpeed: 50.0, canFire: true, fireRate: 0.5, bulletSpeed: 200.0, bulletDamage: 25.0, texture: texture)
        
        //TODO: add Harvester claw child
        
        //physics
        self.physicsBody =
            SKPhysicsBody(texture: self.texture, size:self.size)
        self.physicsBody?.dynamic = true
        self.physicsBody?.usesPreciseCollisionDetection = false
        self.physicsBody?.categoryBitMask = CollisionCategories.Player
        self.physicsBody?.contactTestBitMask = CollisionCategories.EnemyBullet | CollisionCategories.Enemy
        self.physicsBody?.allowsRotation = false
        
        //input
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: {
            (accelerometerData: CMAccelerometerData!, error: NSError!) in
            let acceleration = accelerometerData.acceleration
            self.accelerationX = CGFloat(acceleration.x)
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - METHODS -
    func update(dt: CGFloat, scene: SKScene) {
        //update player position
        if (self.position.x < 0) { //right edge
            self.position.x = 0;
        }
        else if (self.position.x > scene.size.width) { //left edge
            self.position.x = scene.size.width
        }
        else { //move
            self.physicsBody?.velocity = CGVector(dx: (self.accelerationX * 10) * self.movementSpeed, dy: 0)
        }
        
        //update bullet position
        for (var i = 0; i < self.bullets.count; i++){
            self.bullets[i].position.y += self.bulletSpeed * dt
            
            if (self.bullets[i].position.y > scene.size.height + 50){
                self.bullets.removeAtIndex(i)
            }
        }
    }
    
    func fireBullet(scene: SKScene) {
        if(!canFire) {
            return
        }
        else {
            self.canFire = false
            
            let b1 = PlayerBullet(imageName: "laser")
            b1.position.x = self.position.x - 10
            b1.position.y = self.position.y + self.size.height / 2 + 5
            
            let b2 = PlayerBullet(imageName: "laser")
            b2.position.x = self.position.x + 10
            b2.position.y = self.position.y + self.size.height / 2 + 5
            
            self.bullets.append(b1)
            self.bullets.append(b2)
            scene.addChild(b1)
            scene.addChild(b2)
            
            let waitToEnableFire = SKAction.waitForDuration(self.fireRate)
            runAction(waitToEnableFire, completion: { self.canFire = true })
        }
    }
    
    func fireHarvester() {
        //TODO: implement harvester
    }
    
    func takeDamage(damage: CGFloat) {
        if(invincible == false) {
            self.health! -= damage
            turnInvincible()
        }
    }
    
    func die() {
        let gameOverScene = GameOverScene(size: self.scene!.size)
        gameOverScene.scaleMode = self.scene!.scaleMode
        let transitionType = SKTransition.flipHorizontalWithDuration(0.5)
        self.scene!.view!.presentScene(gameOverScene, transition: transitionType)
    }
    
    func turnInvincible(){
        invincible = true
        
        let fadeOutAction = SKAction.fadeOutWithDuration(0.25)
        let fadeInAction = SKAction.fadeInWithDuration(0.25)
        let fadeOutIn = SKAction.sequence([fadeOutAction, fadeInAction])
        
        let fadeOutInAction = SKAction.repeatAction(fadeOutIn, count: 4)
        let setInvicibleFalse = SKAction.runBlock() {
            self.invincible = false
        }
        
        runAction(SKAction.sequence([fadeOutInAction, setInvicibleFalse]))
    }
}
