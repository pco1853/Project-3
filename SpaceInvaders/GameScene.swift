//
//  GameScene.swift
//  SpaceInvaders
//
//  Created by Student on 4/21/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import SpriteKit
import CoreMotion

var invaderNum = 1
var score = 0
struct CollisionCategories{
    static let Invader : UInt32 = 0x1 << 0
    static let UFO: UInt32 = 0x1 << 1
    static let Player: UInt32 = 0x1 << 2
    static let InvaderBullet: UInt32 = 0x1 << 3
    static let PlayerBullet: UInt32 = 0x1 << 4
    static let EdgeBody: UInt32 = 0x1 << 5
    
}


class GameScene: SKScene, SKPhysicsContactDelegate
{
    
    let rowsOfInvaders = 4
    var invaderSpeed:CGFloat = 80.0
    let leftBounds = CGFloat(30)
    var rightBounds = CGFloat(0)
    var invadersWhoCanFire:[Invader] = []
    let player:Player = Player()
    var ufoSpeed: CGFloat = 300.0
    var ufoTimer: CGFloat = 0.0
    var ufoShouldSpawn = true
    let maxLevels = 3
    let motionManager: CMMotionManager = CMMotionManager()
    var accelerationX: CGFloat = 0.0
    var scoreLabel: SKLabelNode = SKLabelNode()
    var lifeLabel: SKLabelNode = SKLabelNode()
    
    var lastUpdateTimeInterval:CFTimeInterval = -1.0
    var deltaTime: CGFloat = 0.0
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        
        backgroundColor = SKColor.blackColor()
        rightBounds = self.size.width - 30
        setupInvaders()
        setupPlayer()
        invokeInvaderFire()
        setupAccelerometer()
        setUpHUD()
        
        self.physicsWorld.gravity=CGVectorMake(0, 0)
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFromRect: frame)
        self.physicsBody?.categoryBitMask = CollisionCategories.EdgeBody
        
        backgroundColor = SKColor.blackColor()
        let starField = SKEmitterNode(fileNamed: "StarField")
        starField.position = CGPointMake(size.width/2,size.height)
        starField.zPosition = -1000
        addChild(starField)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            player.fireBullet(self)
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        //setting up delta time
        deltaTime = CGFloat(currentTime - lastUpdateTimeInterval)
        lastUpdateTimeInterval = currentTime
        if deltaTime > 1
        {
            deltaTime = 1.0 / 60.0
        }
        
        //passing delta time to both invaders and ufo
        setUpUFO(deltaTime)
        moveInvaders(deltaTime)
        
        //updating labels
        lifeLabel.text = "Lives Left: \(player.lives)"
        scoreLabel.text = "Score: \(score)"
    }
    
    func setupPlayer(){
        player.position = CGPoint(x:CGRectGetMidX(self.frame), y:player.size.height/2 + 10)
        addChild(player)
    }
    
    func setUpUFO(deltaTime: CGFloat)
    {
        ufoTimer += deltaTime
        //only spawn the ufo if one isn't on screen and 10 seconds have passed
        if (ufoTimer >= 10.0 && ufoShouldSpawn == true)
        {
            ufoTimer = 0.0
            
            let ufo:UFO = UFO()
            ufo.position = CGPoint(x: size.width / 2 + 75, y: (size.height - ufo.size.height) - 50)
            addChild(ufo)
            ufoShouldSpawn = false
        }
        
        //doing UFO code similar to the invader code
        var changeUFO = false
        enumerateChildNodesWithName("ufo") { node, stop in
         let temp = node as SKSpriteNode
            temp.position.x -= CGFloat(self.ufoSpeed * deltaTime)
            
            if(temp.position.x >= self.rightBounds - (temp.size.width / 2) || temp.position.x <= self.leftBounds + (temp.size.width / 2))
            {
                changeUFO = true
            }
            
            //just have ufo bounce back and forth across screen
            if (changeUFO == true)
            {
                self.ufoSpeed *= -1
                changeUFO = false
            }
        }
    }
    
    //HUD for scoring and lives
    func setUpHUD()
    {
        scoreLabel = SKLabelNode(fontNamed: "Courier")
        scoreLabel.fontSize = 35
        scoreLabel.fontColor = SKColor.greenColor()
        scoreLabel.position = CGPoint(x: self.leftBounds + 160, y: size.height - 60)
        addChild(scoreLabel)
        
        lifeLabel = SKLabelNode(fontNamed: "Courier")
        lifeLabel.fontSize = 35
        lifeLabel.fontColor = SKColor.greenColor()
        lifeLabel.position = CGPoint(x: self.rightBounds - 160, y: size.height - 60)
        addChild(lifeLabel)
    }
    
    func setupInvaders()
    {
        var invaderRow = 0;
        var invaderColumn = 0;
        let numberOfInvaders = invaderNum * 2 + 1
        for var i = 1; i <= rowsOfInvaders; i++ {
            invaderRow = i
            for var j = 1; j <= numberOfInvaders; j++ {
                invaderColumn = j
                let tempInvader:Invader = Invader()
                let invaderHalfWidth:CGFloat = tempInvader.size.width/2
                let xPositionStart:CGFloat = size.width/2 - invaderHalfWidth - (CGFloat(invaderNum) * tempInvader.size.width) + CGFloat(10)
                tempInvader.position = CGPoint(x:xPositionStart + ((tempInvader.size.width+CGFloat(10))*(CGFloat(j-1))), y:CGFloat(self.size.height - CGFloat(i) * 46) - 46)
                tempInvader.invaderRow = invaderRow
                tempInvader.invaderColumn = invaderColumn
                addChild(tempInvader)
                if(i == rowsOfInvaders){
                    invadersWhoCanFire.append(tempInvader)
                }
            }
        }
    }
    
    func moveInvaders(deltaTime: CGFloat)
    {
        var changeDirection = false
        enumerateChildNodesWithName("invader") { node, stop in
            let invader = node as SKSpriteNode
            let invaderHalfWidth = invader.size.width/2
            invader.position.x -= CGFloat(self.invaderSpeed * deltaTime)
            if(invader.position.x > self.rightBounds - invaderHalfWidth || invader.position.x < self.leftBounds + invaderHalfWidth){
                changeDirection = true
            }
            
        }
        
        if(changeDirection == true){
            self.invaderSpeed *= -1
            self.enumerateChildNodesWithName("invader") { node, stop in
                let invader = node as SKSpriteNode
                invader.position.y -= CGFloat(46)
            }
            changeDirection = false
        }
        
    }
    
    func invokeInvaderFire(){
        let fireBullet = SKAction.runBlock(){
            self.fireInvaderBullet()
        }
        let waitToFireInvaderBullet = SKAction.waitForDuration(1.5)
        let invaderFire = SKAction.sequence([fireBullet,waitToFireInvaderBullet])
        let repeatForeverAction = SKAction.repeatActionForever(invaderFire)
        runAction(repeatForeverAction)
    }
    
    
    func levelComplete()
    {
        if(invaderNum <= maxLevels)
        {
            let levelCompleteScene = LevelCompleteScene(size: size)
            levelCompleteScene.scaleMode = scaleMode
            let transitionType = SKTransition.flipHorizontalWithDuration(0.5)
            view?.presentScene(levelCompleteScene,transition: transitionType)
        }
        else
        {
            invaderNum = 1
            score = 0
            newGame()
        }
    }
    

    func fireInvaderBullet() {
        if (invadersWhoCanFire.isEmpty) {
            invaderNum += 1
            levelComplete()
        }
        else {
            let randomInvader = invadersWhoCanFire.randomElement()
            randomInvader.fireBullet(self)
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact)
    {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        
        if ((firstBody.categoryBitMask & CollisionCategories.Player != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.InvaderBullet != 0)) {
                player.die()
        }
        
        if ((firstBody.categoryBitMask & CollisionCategories.Invader != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.Player != 0)) {
              player.kill()
                
        }
        
        //Contact between bullet and ufo should despawn UFO, add a life, and 1000 points
        if((firstBody.categoryBitMask & CollisionCategories.UFO != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.PlayerBullet != 0)){
           
                ufoShouldSpawn = true
                ufoTimer = 0.0
                score += 1000
                player.addLife()
                if (contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil)
                {
                    return
                }
                
                //remove ufo and bullet when they hit
                firstBody.node?.removeFromParent()
                secondBody.node?.removeFromParent()
        }
        
        //plus 50 points for shooting an invader
        if ((firstBody.categoryBitMask & CollisionCategories.Invader != 0) &&
            (secondBody.categoryBitMask & CollisionCategories.PlayerBullet != 0))
        {
            if (contact.bodyA.node?.parent == nil || contact.bodyB.node?.parent == nil)
            {
                return
            }
            score += 50
            
            let invadersPerRow = invaderNum * 2 + 1
            let theInvader = firstBody.node? as Invader
            let newInvaderRow = theInvader.invaderRow - 1
            let newInvaderColumn = theInvader.invaderColumn
            if(newInvaderRow >= 1)
            {
                self.enumerateChildNodesWithName("invader"){ node, stop in
                let invader = node as Invader
                    if invader.invaderRow == newInvaderRow && invader.invaderColumn == newInvaderColumn
                    {
                        self.invadersWhoCanFire.append(invader)
                        stop.memory = true
                    }
                }
            }
            
            let invaderIndex = findIndex(invadersWhoCanFire,valueToFind: firstBody.node? as Invader)
            
            if(invaderIndex != nil)
            {
                invadersWhoCanFire.removeAtIndex(invaderIndex!)
            }
            
            theInvader.removeFromParent()
            secondBody.node?.removeFromParent()
                
        }
    }

    func findIndex<T: Equatable>(array: [T], valueToFind: T) -> Int?
    {
        for (index, value) in enumerate(array) {
            if value == valueToFind {
                return index
            }
        }
        return nil
    }
    
    //reset score for new game
    func newGame()
    {
        score = 0
        let gameOverScene = StartGameScene(size: size)
        gameOverScene.scaleMode = scaleMode
        let transitionType = SKTransition.flipHorizontalWithDuration(0.5)
        view?.presentScene(gameOverScene,transition: transitionType)
    }
    
    func setupAccelerometer(){
        motionManager.accelerometerUpdateInterval = 0.2
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: {
            (accelerometerData: CMAccelerometerData!, error: NSError!) in
            let acceleration = accelerometerData.acceleration
            self.accelerationX = CGFloat(acceleration.x)
        })
    }
    
    override func didSimulatePhysics() {
        player.physicsBody?.velocity = CGVector(dx: accelerationX * 600, dy: 0)
    }
}

