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

enum EnemyDirection{
    case Right
    case Left
    case DownThenRight
    case DownThenLeft
    case None
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //MARK: - Variables -
    //player
    var player: Player!
    var score = 0
    
    //game
    //var enemies: [Enemy] = []
    var wave = 1
    var waveTimer: CFTimeInterval = 10.0
    var difficulty = 1
    var fighter: Fighter!
    
    //enemy movement variables
    var enemyDirection: EnemyDirection = .Right
    var timeOfLastMove: CFTimeInterval = 0.0
    let timePerMove: CFTimeInterval = 1.0
    
    //animation
    var lastUpdateTimeInterval: CFTimeInterval = -1.0
    var dt: CGFloat = 0.0
    
    //ui
    var healthLabel: HUDText!
    var scoreLabel: HUDText!
    var pauseButton: MenuButton!
    var unpauseButton: MenuButton!
    
    //input
    var virtualController: VirtualController?
    let motionManager = CMMotionManager()
    var accelerationX: CGFloat = 0.0
    
    //MARK: - Initialization -
    override func didMoveToView(view: SKView) {
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
        
        self.view?.multipleTouchEnabled = true
    }
    
    func setupPlayer() {
        self.player = Player(); //TODO: generate player based on game data
        self.player.position = CGPoint(x: size.width / 2, y: player.size.height + 100)
        self.addChild(self.player)
    }
    
    func setupEnemies() {
        //TODO:
        self.fighter = Fighter()
        self.fighter.position = CGPoint(x: size.width / 2, y: fighter.size.width)
        self.addChild(self.fighter)

    }
    
    func moveEnemies(currentTime: CFTimeInterval){
        if (currentTime - timeOfLastMove < timePerMove) {
            return
        }
        
        enumerateChildNodesWithName("fighter", usingBlock: { (node: SKNode!, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
            switch self.enemyDirection {
            case .Right:
                node.position = CGPoint(x: node.position.x + 10, y: node.position.y)
            case .Left:
                node.position = CGPoint(x: node.position.x - 10, y: node.position.y)
            case .None:
                break
            default:
                break
            }
            
            self.timeOfLastMove = currentTime
        })
    }
    
    func setupHUD() {
        //add labels
        self.healthLabel = HUDText(text: "HEALTH \(self.player.health)", xPos: 20, yPos: size.height - 20)
        self.addChild(self.healthLabel)
        
        self.scoreLabel = HUDText(text: "SCORE \(self.score)", xPos: 20, yPos: size.height - 60)
        self.addChild(self.scoreLabel)
        
        //add buttons
        self.pauseButton = MenuButton(icon: "", label: "PAUSE", name: "pauseButton", xPos: size.width - 120, yPos: size.height - 100, enabled: true)
        self.pauseButton.xScale = 0.5
        self.pauseButton.yScale = 0.5
        self.addChild(self.pauseButton)
        
        self.unpauseButton = MenuButton(icon: "", label: "UNPAUSE", name: "unpauseButton", xPos: size.width - 120, yPos: size.height - 100, enabled: true)
        self.unpauseButton.xScale = 0.5
        self.unpauseButton.yScale = 0.5
    }
    
    func setupInput() {
        //determine movement scheme
        if(gameData.controlScheme == "motion") {
            motionManager.accelerometerUpdateInterval = 0.2
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: {
                (accelerometerData: CMAccelerometerData!, error: NSError!) in
                let acceleration = accelerometerData.acceleration
                self.accelerationX = CGFloat(acceleration.x)
            })
        }
        else {
            virtualController = VirtualController(size: size)
            addChild(virtualController!)
        }
    }
    
    //MARK: - Input -
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches
        {
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            if(gameData.controlScheme == "motion")
            {
                player.fireBullet(self)
            }
            else
            {
                if(touchedNode.name == "RightArrow")
                {
                    self.accelerationX = 0.5
                }
                else if(touchedNode.name == "LeftArrow")
                {
                    self.accelerationX = -0.5
                }
                else if(touchedNode.name == "Shoot")
                {
                    player.fireBullet(self)
                }
                else if(touchedNode.name == "Harvest")
                {
                    //harvest code
                }
            }
            
            if (touchedNode.name == "pauseButton" && self.pauseButton.enabled){
                self.runAction(SKAction.runBlock(self.pauseGame))
                pauseButton.removeFromParent()
                addChild(unpauseButton)
                
                //maybe add blur effect?
                
            }
            else if (touchedNode.name == "unpauseButton" && self.unpauseButton.enabled){
                self.view!.paused = false
                unpauseButton.removeFromParent()
                addChild(pauseButton)
            }
        }
    }
    
    func pauseGame(){
        self.view!.paused = true
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent)
    {
        for touch: AnyObject in touches
        {
            
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            if(touchedNode.name == "RightArrow")
            {
                self.accelerationX = 0.0
            }
            else if(touchedNode.name == "LeftArrow")
            {
                self.accelerationX = 0.0
            }
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
        moveEnemies(currentTime)
        
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
    
    func updatePlayer()
    {
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
        healthLabel.text = "HEALTH: \(player.health)"
        scoreLabel.text = "SCORE: \(score)"
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

