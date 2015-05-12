//
//  GameScene.swift
//
//  Created by Student on 4/21/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import SpriteKit
import CoreMotion

struct CollisionCategories {
    static let Player: UInt32 = 0x1 << 0
    static let Enemy: UInt32 = 0x1 << 1
    static let PlayerBullet: UInt32 = 0x1 << 2
    static let EnemyBullet: UInt32 = 0x1 << 3
}


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //MARK: - Variables -
    //game
    var player:Player!
    //var enemies[Enemy] = []
    var score = 0
    var lastUpdateTimeInterval: CFTimeInterval = -1.0
    var dt: CGFloat = 0.0
    
    //ui
    var healthLabel: SKLabelNode = SKLabelNode()
    var scoreLabel: SKLabelNode = SKLabelNode()
    
    //virtual controller
    var virtualController:VirtualController?
    
    //input
    let motionManager = CMMotionManager()
    var accelerationX: CGFloat = 0.0
    
    //MARK: - Initialization -
    override func didMoveToView(view: SKView) {
        //init physics
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        
        backgroundColor = SKColor.blueColor()
        /*let starField = SKEmitterNode(fileNamed: "StarField")
        starField.position = CGPointMake(size.width / 2, size.height)
        starField.zPosition = -1000
        addChild(starField)*/
        
        setupPlayer()
        setupEnemies()
        setupHUD()
        setupInput()
        
        virtualController = VirtualController(size: size)
        addChild(virtualController!)
    }
    
    func setupPlayer() {
        player = Player(); //TODO: generate player based on game data
        player.position = CGPoint(x: CGRectGetMidX(self.frame), y: player.size.height + 20)
        addChild(player)
    }
    
    func setupEnemies() {
        
    }
    
    func setupHUD() {
        healthLabel = SKLabelNode(fontNamed: "Courier")
        healthLabel.fontSize = 24
        healthLabel.fontColor = SKColor.whiteColor()
        healthLabel.horizontalAlignmentMode = .Left
        healthLabel.verticalAlignmentMode = .Top
        healthLabel.position = CGPoint(x: 20, y: size.height - 20)
        addChild(healthLabel)
        
        scoreLabel = SKLabelNode(fontNamed: "Courier")
        scoreLabel.fontSize = 24
        scoreLabel.fontColor = SKColor.whiteColor()
        scoreLabel.horizontalAlignmentMode = .Left
        scoreLabel.verticalAlignmentMode = .Top
        scoreLabel.position = CGPoint(x: 20, y: size.height - 60)
        addChild(scoreLabel)
    }
    
    func setupInput() {
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: {
            (accelerometerData: CMAccelerometerData!, error: NSError!) in
            let acceleration = accelerometerData.acceleration
            self.accelerationX = CGFloat(acceleration.x)
        })
    }
    
    //MARK: - Input -
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            player.fireBullet(self)
        }
    }
    
    //MARK: - Game Loop -
    override func update(currentTime: CFTimeInterval) {
        //calculate dt
        dt = CGFloat(currentTime - lastUpdateTimeInterval)
        lastUpdateTimeInterval = currentTime
        if (dt > 1) {
            dt = 1.0 / 60.0
        }
        
        updatePlayer()
        updateEnemies()
        updateHUD()
        
        //check for level complete
        /*if (enemiesAreDead()){
            levelComplete()
        }*/
        
        //check for player death
        if (player.health <= 0) {
            player.health = 0;
            levelFail();
        }
    }
    
    func updatePlayer() {
        //move player
        player.physicsBody?.velocity = CGVector(dx: (accelerationX * 100) * (player.movementSpeed * dt), dy: 0)
        
        //check player bounds
        if (player.position.x - player.size.width / 2 < 20.0) { //left edge
            player.position.x = player.size.width / 2 + 20.0
        }
        else if (player.position.x + player.size.width / 2 > self.size.width - 20.0) { //right edge
            player.position.x = self.size.width - player.size.width / 2 - 20.0
        }
        
        //move player bullets
        for (var i = 0; i < player.bullets.count; i++) {
            player.bullets[i].position.y += player.bulletSpeed * dt
        }
        
        //check player bullet bounds
        for (var i = 0; i < player.bullets.count; i++) {
            if (player.bullets[i].position.y >= self.size.height + 50){
                player.bullets[i].removeFromParent()
                player.bullets.removeAtIndex(i)
            }
        }
    }
    
    func updateEnemies() {
        //TODO: implement method
    }
    
    func updateHUD() {
        healthLabel.text = "Health: \(player.health)"
        scoreLabel.text = "Score: \(score)"
    }
    
    //MARK: - Collision -
    func didBeginContact(contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        //player shot by bullet
        if ((firstBody.categoryBitMask & CollisionCategories.Player != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.EnemyBullet != 0)) {
                player.takeDamage(25.0)
                secondBody.node?.removeFromParent()
        }
        
        //player and enemy hit
        if ((firstBody.categoryBitMask & CollisionCategories.Player != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.Enemy != 0)) {
                player.takeDamage(50.0)
                secondBody.node?.removeFromParent()
        }
        
        //player shoots enemy
        if ((firstBody.categoryBitMask & CollisionCategories.Enemy != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.PlayerBullet != 0)) {
            if (contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil) {
                return
            }
                
            score += 100
            
            /*
            let enemy = firstBody.node? as Enemy
            enemy.explode()
            enemy.removeFromParent()
            */
            
            secondBody.node?.removeFromParent()
        }
    }

    //MARK - Transitions -
    func levelComplete() {
        let levelCompleteScene = LevelCompleteScene(size: size)
        levelCompleteScene.scaleMode = scaleMode
        let transitionType = SKTransition.flipHorizontalWithDuration(0.5)
        view?.presentScene(levelCompleteScene,transition: transitionType)
    }
    
    func levelFail() {
        let gameOverScene = GameOverScene(size: size)
        gameOverScene.scaleMode = scaleMode
        let transitionType = SKTransition.flipHorizontalWithDuration(0.5)
        view?.presentScene(gameOverScene,transition: transitionType)
    }
    
}

