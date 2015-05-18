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
    var player: Player!
    var enemies: [Enemy] = []
    var wave = 1
    var waveTimer: CFTimeInterval = 10.0
    var difficulty = 1

    //animation
    var lastUpdateTimeInterval: CFTimeInterval = -1.0
    var dt: CGFloat = 0.0
    
    //ui
    var healthLabel: HUDText!
    var scoreLabel: HUDText!
    var pauseButton: MenuButton!
    var pauseMenu: PauseScene!

    //input
    var accelerationX: CGFloat = 0.0
    var accelerationY: CGFloat = 0.0
    
    //virtual joystick
    var virtualController: VirtualController?
    var fireButtonPressed = false
    var harvestButtonPressed = false
    var powerupButtonPressed = false
    
    //accelerometer
    var motionManager: CMMotionManager?
    
    //MARK: - Initialization -
    override func didMoveToView(view: SKView) {
        //end menu background sound
        sharedAudio.stopAudio()
        
        //init physics
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        
        //set background
        backgroundColor = SKColor.blackColor()
        let starField = SKEmitterNode(fileNamed: "StarField")
        starField.position = CGPointMake(size.width / 2, size.height + 100)
        starField.zPosition = -1000
        starField.advanceSimulationTime(15.0)
        addChild(starField)
        
        //setup game
        setupPlayer()
        setupEnemies()
        setupHUD()
        setupInput()
    }
    
    func setupPlayer() {
        self.player = Player()
        self.player.position = CGPoint(x: size.width / 2, y: player.size.height + 100)
        self.addChild(self.player)
    }
    
    func setupEnemies() {
        //TODO: generate waves from data
        
        //FOR TESTING:
        let fighter = Fighter()
        let kamikaze = Kamikaze()
        let bomber = Bomber()
        
        fighter.position = CGPoint(x: size.width / 2, y: size.height - 150)
        kamikaze.position = CGPoint(x: size.width / 2 - 100, y: size.height - 300)
        bomber.position = CGPoint(x: size.width / 2 + 150, y: size.height - 100)

        self.enemies.append(fighter)
        self.enemies.append(kamikaze)
        self.enemies.append(bomber)
        
        for enemy in self.enemies {
            self.addChild(enemy)
        }
    }
    
    func setupHUD() {
        //add labels
        self.healthLabel = HUDText(text: "HEALTH \(self.player.health)", xPos: 20, yPos: size.height - 20)
        self.addChild(self.healthLabel)
        
        self.scoreLabel = HUDText(text: "SCORE \(gameData.score)", xPos: 20, yPos: size.height - 60)
        self.addChild(self.scoreLabel)
        
        //add buttons
        self.pauseButton = MenuButton(icon: "", label: "PAUSE", name: "pauseButton", xPos: size.width - 120, yPos: size.height - 100, enabled: true)
        self.pauseButton.zPosition = 1000
        self.pauseButton.xScale = 0.5
        self.pauseButton.yScale = 0.5
        self.addChild(self.pauseButton)
    }
    
    func setupInput() {
        self.view?.multipleTouchEnabled = true
        
        if(gameData.controlScheme == "motion") {
            //create motion manager
            self.motionManager = CMMotionManager()
            self.motionManager?.accelerometerUpdateInterval = 0.2
            
            //listen to motion events
            self.motionManager?.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: {
                (accelerometerData: CMAccelerometerData!, error: NSError!) in
                let acceleration = accelerometerData.acceleration
                self.accelerationX = CGFloat(acceleration.x)
                self.accelerationY = CGFloat(acceleration.y * 1.2)
            })
        }
        else {
            //create virtual controller
            self.virtualController = VirtualController(size: size)
            self.addChild(self.virtualController!)
        }
        
        self.accelerationX = 0.0
        self.accelerationY = 0.0
    }
    
    //MARK: - Input -
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            //HUD input
            if (touchedNode.name == "pauseButton" && self.pauseButton.enabled) {
                self.pauseButton.enabled = false
                
                if (!self.view!.paused) {
                    
                    self.runAction(SKAction.runBlock({
                        self.pauseButton.removeFromParent()
                        self.paused = true
                    }))
                    
                    self.pauseMenu = PauseScene(size: self.size, title: "PAUSE", view: self.view!)
                    addChild(self.pauseMenu)
                }
                
            }
                
            
            //game input
            else if (gameData.controlScheme == "motion") {
                self.fireButtonPressed = true
            }
            else if (gameData.controlScheme == "virtual") {
                if(touchedNode.name == "fireButton" && self.virtualController!.fireButton.enabled) {
                    self.fireButtonPressed = true
                    self.virtualController!.fireButton.highlight()
                }
                else if(touchedNode.name == "harvestButton" && self.virtualController!.fireButton.enabled) {
                    self.harvestButtonPressed = true
                    self.virtualController!.harvestButton.highlight()
                }
                else if(touchedNode.name == "powerupButton" && self.virtualController!.fireButton.enabled) {
                    self.powerupButtonPressed = true
                    self.virtualController!.powerupButton.highlight()
                }
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            if (fireButtonPressed) {
                self.fireButtonPressed = false
                
                if (self.virtualController != nil) {
                    self.virtualController!.fireButton.undoHighlight()
                }
            }
            
            if (harvestButtonPressed) {
                self.harvestButtonPressed = false
                
                if (self.virtualController != nil) {
                    self.virtualController!.harvestButton.undoHighlight()
                }
            }
            
            if (powerupButtonPressed) {
                self.powerupButtonPressed = false
                
                if (self.virtualController != nil) {
                    self.virtualController!.powerupButton.undoHighlight()
                }
            }
        }
    }
    
    func checkInput() {
        //joystick
        if (gameData.controlScheme == "virtual") {
            if (self.virtualController!.joystick.velocity.x != 0 || self.virtualController!.joystick.velocity.y != 0) {
                self.accelerationX = self.virtualController!.joystick.velocity.x / 60
                self.accelerationY = self.virtualController!.joystick.velocity.y / 60
            }
                //logic for making the player slow to a stop instead of coming to a dead stop when the joystick is released
            else if (self.virtualController!.joystick.velocity.x == 0 || self.virtualController!.joystick.velocity.y == 0) {
                //slow down the X coordinate
                if (self.player.physicsBody?.velocity.dx > 1.0) {
                    self.accelerationX -= 0.02
                }
                else if player.physicsBody?.velocity.dx < 1.0 {
                    self.accelerationX += 0.02
                }
                else {
                    self.accelerationX = 0.0
                    self.accelerationY = 0.0
                }
                
                //slow down the Y coordinate
                if (self.player.physicsBody?.velocity.dy > 1.0) {
                    self.accelerationY -= 0.02
                }
                else if (self.player.physicsBody?.velocity.dy < 1.0) {
                    self.accelerationY += 0.02
                }
                else {
                    self.accelerationY = 0.0
                    self.accelerationX = 0.0
                }
            }
        }
        
        //button/touch actions
        if (self.fireButtonPressed) {
            self.player.fireBullet(self)
        }
        else if (self.harvestButtonPressed) {
            self.player.fireHarvester()
        }
        else if (self.fireButtonPressed) {
            self.player.firePowerup()
        }
    }
    
    //MARK: - Game Loop -
    override func update(currentTime: CFTimeInterval) {
        //check for pause
        if (self.paused) {
            return
        }
        
        
        checkGameOver()
        
        checkBounds()
        
        checkInput()
        
        //calculate dt
        self.dt = CGFloat(currentTime - self.lastUpdateTimeInterval)
        self.lastUpdateTimeInterval = currentTime
        if (dt > 1) { //catch invalid values
            dt = 1.0 / 60.0
        }
        
        //update game objects
        updatePlayer()
        updateEnemies()
        updateBullets()
        updateHUD()
    }
    
    func updatePlayer() {
        //set player velocity
        self.player.setVelocityFromAcceleration(accelX: self.accelerationX, accelY: self.accelerationY, dt: self.dt)
        self.player.setEngineParticle()
    }
    
    func updateEnemies() {
        for enemy in self.enemies {
            
            //move
            if (enemy.moveDirection == "left") {
                enemy.setVelocity(x: -enemy.movementSpeed, y: 0.0, dt: self.dt)
            }
            else if (enemy.moveDirection == "right") {
                enemy.setVelocity(x: enemy.movementSpeed, y: 0.0, dt: self.dt)
            }
            
            //fire bullets/bomb/self
            if (enemy.name == "fighter") {
                let e = enemy as Fighter
                e.fireBullet(self)
            }
            else if (enemy.name == "bomber") {
                let e = enemy as Bomber
                e.fireBomb(self)
            }
            else if (enemy.name == "kamikaze") {
                let e = enemy as Kamikaze
                
                if (e.position.x > self.player.position.x - self.player.size.width &&
                    e.position.x < self.player.position.x + self.player.size.width) {
                    e.fire()
                }
                
                if (e.canFire){
                    e.setVelocity(x: 0.0, y: -e.movementSpeed, dt: self.dt)
                }
            }
        }
    }
    
    func updateBullets() {
        //player bullets
        self.enumerateChildNodesWithName("playerBullet", usingBlock: {
            (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            
            let b = node as PlayerBullet
            b.position.y += (self.player.bulletSpeed) * self.dt
            
            if (b.position.y > self.size.height + 50.0) {
                b.removeFromParent()
            }
        })
        
        //enemy fighter bullets
        self.enumerateChildNodesWithName("enemyBullet", usingBlock: {
            (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            
            let b = node as EnemyBullet
            b.position.y -= (400.0) * self.dt
            
            if (b.position.y < -50.0) {
                b.removeFromParent()
            }
        })
        
        //enemy bombs
        self.enumerateChildNodesWithName("enemyBomb", usingBlock: {
            (node: SKNode!, stop: UnsafeMutablePointer <ObjCBool>) -> Void in
            
            let b = node as EnemyBullet
            
            if (b.position.y > self.player.position.y - self.player.size.height &&
                b.position.y < self.player.position.y + self.player.size.height) { //explode if in range
                    let texture = SKTexture(imageNamed: "bullet_bombExploding")
                    b.texture = texture
                    let explode = SKAction.scaleXTo(50.0, duration: 2.0)
                    let fadeOut = SKAction.fadeOutWithDuration(0.25)
                    b.runAction(explode, completion: {
                        b.runAction(fadeOut, completion: {
                            b.removeFromParent()
                        })
                    })
            }
            else if (b.xScale == 1.0) { //keep moving down if not exploding
                b.position.y -= (200.0) * self.dt
            }
            
            if(b.position.y < -50.0) {
                b.removeFromParent()
            }
        })
    }
    
    func updateHUD() {
        healthLabel.text = "HEALTH: \(player.health)"
        scoreLabel.text = "SCORE: \(gameData.score)"
    }
    
    func checkBounds()
    {
        //check player bounds
        if (player.position.x - player.size.width / 2 < 20.0) { //left edge
            player.position.x = player.size.width / 2 + 20.0
        }
        else if (player.position.x + player.size.width / 2 > self.size.width - 20.0) { //right edge
            player.position.x = self.size.width - player.size.width / 2 - 20.0
        }
        
        if(player.position.y - player.size.height / 2 < 20.0)
        {
            player.position.y = player.size.height / 2 + 20.0
        }
        else if (player.position.y + player.size.height / 2 > self.size.height - 20.0)
        {
            player.position.y = self.size.height - player.size.height / 2 - 20.0
        }
        
        //check enemy bounds
        for enemy in self.enemies
        {
            if (enemy.position.x - enemy.size.width / 2 < 20.0 && enemy.moveDirection != "None") //left edge
            {
                enemy.position.x = enemy.size.width / 2 + 20.0
                enemy.moveDirection = "Right"
            }
            else if(enemy.position.x + enemy.size.width / 2 > self.size.width - 20.0 && enemy.moveDirection != "None")//right edge
            {
                enemy.position.x = self.size.width - enemy.size.width / 2 - 20.0
                enemy.moveDirection = "Left"
            }
        }
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
                if (contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil) {
                    return
                }
                
                player.takeDamage(25.0)
                secondBody.node?.removeFromParent()
        }
        
        //player and enemy hit
        if ((firstBody.categoryBitMask & CollisionCategories.Player != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.Enemy != 0)) {
                if (contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil) {
                    return
                }
                
                player.takeDamage(50.0)
                
                //Remove enemy
                var enemyIndex = findIndex(self.enemies, valueToFind: secondBody.node? as Enemy)
                if(enemyIndex != nil) {
                    self.enemies.removeAtIndex(enemyIndex!)
                }
                secondBody.node?.removeFromParent()
        }
        
        //player shoots enemy
        if ((firstBody.categoryBitMask & CollisionCategories.Enemy != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.PlayerBullet != 0)) {
            if (contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil) {
                return
            }
                
            gameData.score += 50
                
            //Remove the enemy who got shot from the enemies array
            var enemyIndex = findIndex(self.enemies, valueToFind: firstBody.node? as Enemy)
            if(enemyIndex != nil)
            {
                self.enemies.removeAtIndex(enemyIndex!)
            }
        
                
                firstBody.node?.removeFromParent()
                secondBody.node?.removeFromParent()
        }
    }

    //MARK - Transitions -
    func checkGameOver() {
        if (self.player.health <= 0) {
            self.player.health = 0;
            
            //TODO: animate player death
            //TODO: disable controls
            
            self.runAction(SKAction.runBlock({
                let gameOverScene = GameOverScene(size: self.size, title: "game over")
                gameOverScene.scaleMode = self.scaleMode
                let transition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(gameOverScene, transition: transition)
            }))
        }
    }
    
    //MARK: - Helpers -
    func findIndex<T: Equatable>(array: [T], valueToFind: T) -> Int?
    {
        for (index, value) in enumerate(array) {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
    
}

