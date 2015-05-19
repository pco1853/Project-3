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
    static let Harvester: UInt32 = 0x1 << 4
}

struct DrawOrder {
    static let Background: CGFloat = -1000
    static let EnemyBullets: CGFloat = 0
    static let Enemies: CGFloat = 1
    static let PlayerBullets: CGFloat = 2
    static let HarvesterLinks: CGFloat = 3
    static let Harvester: CGFloat = 4
    static let PlayerParticle: CGFloat = 5
    static let Player: CGFloat = 6
    static let Explosions: CGFloat = 7
    static let UI: CGFloat = 8
    static let PauseMenuBackground: CGFloat = 9
    static let PauseMenu: CGFloat = 10
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //MARK: - Variables -
    //game
    var player: Player!
    var enemies: [Enemy] = []
    var enemyWaves: EnemyWaves!
    var wave = 1
    var waveTimer: CFTimeInterval = 10.0
    var difficulty = 1
    var isPaused = false
    var isGameOver = false
    var lastUpdateTimeInterval: CFTimeInterval = -1.0
    var dt: CGFloat = 0.0
    
    //ui
    var healthLabel: HUDText!
    var scoreLabel: HUDText!
    var harvesterReadyLabel: HUDText!
    var pauseButton: MenuButton!

    //input
    var accelerationX: CGFloat = 0.0
    var accelerationY: CGFloat = 0.0
    var virtualController: VirtualController?
    var fireButtonPressed = false
    var harvestButtonPressed = false
    var motionManager: CMMotionManager?
    
    //pause scene
    var pauseScene: PauseScene!
    
    //sound
    var audioTracks = ["Game Track 1.m4a", "Game Track 2.m4a", "Game Track 3.m4a", "Game Track 4.mp3"]
    var audioTracksShuffled: [String] = []
    var audioTracksIndex = 0
    
    //MARK: - Initialization -
    override func didMoveToView(view: SKView) {
        audioManager.stopAudio()
        enemyWaves = EnemyWaves(size: self.size)
        var swipeUp = UISwipeGestureRecognizer(target: self, action: "Harvest")
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up
        
        //init physics
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        
        //set background
        backgroundColor = SKColor.blackColor()
        let starField = SKEmitterNode(fileNamed: "StarField")
        starField.position = CGPointMake(self.size.width / 2, self.size.height + 100)
        starField.zPosition = DrawOrder.Background
        starField.advanceSimulationTime(15.0)
        addChild(starField)
        
        //setup game
        setupPlayer()
        setupEnemies()
        setupHUD()
        setupInput()
        setupMusic()
    }
    
    func Harvest(){
        println("swipeUp")
    }
    
    func setupPlayer() {
        gameData.score = 0
        
        self.player = Player()
        self.player.position = CGPoint(x: self.size.width / 2, y: player.size.height + 100)
        self.addChild(self.player)
    }

    //spawn an easy wave and have enemies slide in
    func setupEnemies()
    {
        var randomNum = Int(arc4random_uniform(3))
        self.enemies = self.enemyWaves.setNewWave(self.wave, index: randomNum)
        for enemy in self.enemies {
            self.addChild(enemy)
            
            var slideInAction = SKAction.moveToY(enemy.position.y - 500, duration: 2)
            enemy.runAction(slideInAction, completion: {
                enemy.finishedSpawningIn = true
            })
        }
    }
    
    func setupHUD() {
        //add buttons
        self.pauseButton = MenuButton(icon: "", label: "PAUSE", name: "pauseButton", xPos: size.width - 120, yPos: size.height - 120, enabled: true)
        self.pauseButton.zPosition = DrawOrder.UI
        self.pauseButton.xScale = 0.5
        self.pauseButton.yScale = 0.5
        self.addChild(self.pauseButton)
        
        //add labels
        self.healthLabel = HUDText(text: "HEALTH \(self.player.health)", xPos: 60, yPos: self.pauseButton.position.y + self.pauseButton.size.height / 2)
        self.addChild(self.healthLabel)
        
        self.scoreLabel = HUDText(text: "SCORE \(gameData.score)", xPos: 60, yPos: self.healthLabel.position.y - 40)
        self.addChild(self.scoreLabel)
        
        self.harvesterReadyLabel = HUDText(text: "HARVESTER READY", xPos: 60, yPos: self.healthLabel.position.y - 80)
        self.addChild(self.harvesterReadyLabel)
        self.harvesterReadyLabel.alpha = 0
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
                self.accelerationY = CGFloat(acceleration.y)
                
                println(self.accelerationY)
                
                if (self.accelerationY > -0.55) {
                    self.accelerationY = 1.0 + CGFloat(self.motionManager!.accelerometerData.acceleration.y)
                }
                else if (self.accelerationY < -0.75) {
                    self.accelerationY = CGFloat(self.motionManager!.accelerometerData.acceleration.y)
                }
                else {
                    self.accelerationY = 0.0
                }
            })
            
            //set up gesture recognizers
            var upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipes:"))
            upSwipe.direction = .Up
            self.view?.addGestureRecognizer(upSwipe)
        }
        else {
            //create virtual controller
            self.virtualController = VirtualController(size: size)
            self.addChild(self.virtualController!)
        }
        
        self.accelerationX = 0.0
        self.accelerationY = 0.0
    }
    
    func setupMusic() {
        if (gameData.soundEnabled) {
            self.audioTracksShuffled = self.audioTracks.shuffled()
            audioManager.playBackgroundMusic(self.audioTracksShuffled[audioTracksIndex], loops: 1)
        }
    }
    
    //MARK: - Input -
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            //HUD input
            if (touchedNode.name == "pauseButton" && self.pauseButton.enabled) {
                if (!self.isPaused) {
                    self.runAction(SKAction.runBlock({
                        self.pauseButton.enabled = false
                        self.pauseButton.highlight()
                    }), completion: {
                        self.pause()
                    })
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
                    if (self.player.canHarvest) {
                        self.harvestButtonPressed = true
                        self.virtualController!.harvestButton.highlight()
                    }
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
        }
    }
    
    func handleSwipes(sender: UISwipeGestureRecognizer) {
        if (sender.direction == .Up) {
            //println("Swiped up...")
            
            if (self.player.canHarvest) {
                self.harvestButtonPressed = true
            }
            
            self.fireButtonPressed = false
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
        /*
        else if (self.fireButtonPressed) {
            self.player.firePowerup()
        }
        */
        
        //show harvester availability
        if (gameData.controlScheme == "virtual") {
            if (self.player.canHarvest) {
                self.virtualController!.harvestButton.alpha = 1.0
            }
            else {
                self.virtualController!.harvestButton.alpha = 0.25
            }
        }
        else {
            if (self.player.canHarvest) {
                self.harvesterReadyLabel.alpha = 1.0
            }
            else {
                self.harvesterReadyLabel.alpha = 0
            }
        }
    }
    
    //MARK: - Game Loop -
    override func update(currentTime: CFTimeInterval) {
        //check for pause
        if (self.isPaused) {
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
        manageWaves()
        updateMusic()
    }
    
    func updatePlayer() {
        //set player velocity
        self.player.setVelocityFromAcceleration(accelX: self.accelerationX, accelY: self.accelerationY, dt: self.dt)
        self.player.setHarvester(self.dt)
        self.player.setEngineParticle()
    }
    
    func updateEnemies() {
        for (var i = self.enemies.count - 1; i > -1; i--) {
            let enemy = enemies[i]
            
            if(enemy.finishedSpawningIn)
            {
                //check for death
                if (enemy.health <= 0) {
                    enemy.explode(self)
                    self.enemies.removeAtIndex(i)
                
                    gameData.score += 50
                
                    continue
                }
            
                //move
                if (enemy.moveDirection == "left") {
                    enemy.setVelocity(x: -enemy.movementSpeed, y: 0.0, dt: self.dt)
                }
                else if (enemy.moveDirection == "right") {
                    enemy.setVelocity(x: enemy.movementSpeed, y: 0.0, dt: self.dt)
                }
                else
                {
                        
                }
            
                //remove enemies who go below screen
                if (enemy.position.y < -50) {
                    enemy.canFire = false
                    enemy.removeFromParent()
                    var enemyIndex = findIndex(self.enemies, valueToFind: enemy)
                    self.enemies.removeAtIndex(enemyIndex!)
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
    }
    
    //controls the new waves that spawn in the game
    func manageWaves() {
        
        if(self.enemies.count > 0) {
            return
        }
        else
        {
            self.wave += 1
            var randomNum = Int(arc4random_uniform(5))
            self.enemies = self.enemyWaves.setNewWave(self.wave, index: randomNum)
            
            for enemy in self.enemies {
                self.addChild(enemy)
                //slide in enemies when a new wave spawns
                var slideInAction = SKAction.moveToY(enemy.position.y - 500, duration: 2)
                enemy.runAction(slideInAction, completion: {
                    enemy.finishedSpawningIn = true
                })
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
            
            if (b.position.y > self.player.position.y - self.player.size.height / 2 &&
                b.position.y < self.player.position.y + self.player.size.height / 2) { //explode if in range
                    let texture = SKTexture(imageNamed: "bullet_bombExploding")
                    b.texture = texture
                    
                    audioManager.playSoundEffect("bullet_bombExplosion.m4a", node: self)
                    
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
            
            if (b.position.y < -50.0) {
                b.removeFromParent()
            }
        })
    }
    
    func updateHUD() {
        healthLabel.text = "HEALTH: \(player.health)"
        scoreLabel.text = "SCORE: \(gameData.score)"
    }
    
    func updateMusic() {
        if (gameData.soundEnabled && audioManager.player.playing == false) {
            self.audioTracksIndex++
            
            if (self.audioTracksIndex > self.audioTracksShuffled.count - 1) {
                self.audioTracksIndex = 0
            }
            
            audioManager.playBackgroundMusic(self.audioTracksShuffled[self.audioTracksIndex], loops: 1)
        }
    }
    
    func checkBounds() {
        //check player bounds
        if (player.position.x - player.size.width / 2 < 20.0) { //left edge
            player.position.x = player.size.width / 2 + 20.0
        }
        else if (player.position.x + player.size.width / 2 > self.size.width - 20.0) { //right edge
            player.position.x = self.size.width - player.size.width / 2 - 20.0
        }
        if (player.position.y + player.size.height / 2 > self.size.height - 20.0) { //top edge
            player.position.y = self.size.height - player.size.height / 2 - 20.0
        }
        else if (player.position.y - player.size.height / 2 < 20.0) { //bottom edge
            player.position.y = player.size.height / 2 + 20.0
        }
        
        
        //check enemy bounds
        for (var i = self.enemies.count - 1; i > -1; i--) {
            let enemy = self.enemies[i]
            
            if (enemy.position.y <= -100) { //off bottom of screen
                self.enemies.removeAtIndex(i)
                enemy.removeFromParent()
                continue
            }
            
            if (enemy.position.x - enemy.size.width / 2 < 20.0 && enemy.moveDirection != "none") { //left edge
                enemy.position.x = enemy.size.width / 2 + 20.0
                enemy.moveDirection = "right"
            }
            else if(enemy.position.x + enemy.size.width / 2 > self.size.width - 20.0 && enemy.moveDirection != "none") { //right edge
                enemy.position.x = self.size.width - enemy.size.width / 2 - 20.0
                enemy.moveDirection = "left"
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
                
                //TODO: Check type of bullet and deal damage accordingly
                player.takeDamage(25.0, scene: self)
                
                //remove enemy bullet
                secondBody.node?.removeFromParent()
                
        }
        
        //player and enemy hit
        if ((firstBody.categoryBitMask & CollisionCategories.Player != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.Enemy != 0)) {
                if (contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil) {
                    return
                }
                
                //damage player
                player.takeDamage(50.0, scene: self)
                
                //explode and remove enemy
                let enemyIndex = findIndex(self.enemies, valueToFind: secondBody.node? as Enemy)
                if(enemyIndex != nil) {
                    self.enemies[enemyIndex!].explode(self)
                    self.enemies.removeAtIndex(enemyIndex!)
                }
        }
        
        //player shoots enemy
        if ((firstBody.categoryBitMask & CollisionCategories.Enemy != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.PlayerBullet != 0)) {
            if (contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil) {
                return
            }
                
            //damage enemy
            let e = firstBody.node? as Enemy
            e.takeDamage(self.player.bulletDamage, scene: self)
            if(e.health <= 0 && e.finishedSpawningIn == false)
            {
                let enemyIndex = findIndex(self.enemies, valueToFind: e)
                if(enemyIndex != nil)
                {
                    self.enemies.removeAtIndex(enemyIndex!)
                    gameData.score += 50
                    e.removeFromParent()
                }
            }
            //remove player bullet
            secondBody.node?.removeFromParent()
        }
        
        //player harvests enemy
        if ((firstBody.categoryBitMask & CollisionCategories.Enemy != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.Harvester != 0)) {
                if (contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil) {
                    return
                }
                
                //heal player
                let e = firstBody.node? as Enemy
                self.player.harvest(e.health / 2.0)
                
                //explode and remove enemy
                let enemyIndex = findIndex(self.enemies, valueToFind: firstBody.node? as Enemy)
                if(enemyIndex != nil) {
                    self.enemies[enemyIndex!].explode(self)
                    self.enemies.removeAtIndex(enemyIndex!)
                }
                //firstBody.node?.removeFromParent() -> handled in the explode() call
        }
    }

    //MARK: - Transitions -
    func pause() {
        self.isPaused = true
        
        self.pauseButton.alpha = 0
        self.healthLabel.alpha = 0
        self.scoreLabel.alpha = 0
        self.virtualController?.alpha = 0
        
        let screen = self.getBlurredScreenshot()
        self.pauseScene = PauseScene(size: self.size, title: "pause", background: screen)
        
        self.paused = true
        self.addChild(self.pauseScene)
    }
    
    func resume() {
        self.pauseButton.enabled = true
        self.pauseButton.undoHighlight()
        
        self.pauseButton.alpha = 1.0
        self.healthLabel.alpha = 1.0
        self.scoreLabel.alpha = 1.0
        self.virtualController?.alpha = 1.0
        self.pauseScene.removeFromParent()
        
        self.isPaused = false
    }
    
    func quit() {
        audioManager.stopAudio()
        
        let scene = GameModeScene(size: self.size, title: "mode")
        scene.scaleMode = self.scaleMode
        let transition = SKTransition.fadeWithDuration(1.0)
        self.view?.presentScene(scene, transition: transition)
    }
    
    func checkGameOver() {
        if (!self.isGameOver && self.player.isDead) {
            self.isGameOver = true
            
            //TODO: disable controls
            gameData.highScores.append(gameData.score)
            
            gameData.filterHighScores(gameData.score)
            
            self.runAction(SKAction.waitForDuration(2.0), completion: {
                audioManager.stopAudio()
                
                let gameOverScene = GameOverScene(size: self.size, title: "game over")
                gameOverScene.scaleMode = self.scaleMode
                let transition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(gameOverScene, transition: transition)
            })
        }
    }
    
    //MARK: - Helpers -
    //credit: http://stackoverflow.com/questions/22490818/how-do-i-blur-a-scene-in-spritekit
    func getBlurredScreenshot() -> SKSpriteNode {
        UIGraphicsBeginImageContextWithOptions(CGSize(
            width: self.view!.frame.size.width,
            height: self.view!.frame.size.height),
            true,
            1
        )
        self.view!.drawViewHierarchyInRect(self.view!.frame, afterScreenUpdates: true)
        
        let context = UIGraphicsGetCurrentContext()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        let ciContext = CIContext(options: nil)
        let coreImage = CIImage(image: image)
        let filter = CIFilter(name: "CIGaussianBlur")
        filter.setValue(coreImage, forKey: kCIInputImageKey)
        filter.setValue(10, forKey: kCIInputRadiusKey)
        
        let filteredImageData = filter.valueForKey(kCIOutputImageKey) as CIImage
        let filteredImageRef = ciContext.createCGImage(filteredImageData, fromRect: filteredImageData.extent())
        let filteredImage = UIImage(CGImage: filteredImageRef)
        
        let texture = SKTexture(image: filteredImage!)
        let sprite = SKSpriteNode(texture: texture, color: SKColor.clearColor(), size: self.size)
        
        return sprite
    }
    
    func findIndex<T: Equatable>(array: [T], valueToFind: T) -> Int? {
        for (index, value) in enumerate(array) {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
    
}

