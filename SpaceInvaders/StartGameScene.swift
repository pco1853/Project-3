//
//  StartGameScene.swift
//  SpaceInvaders
//
//  Created by Student on 4/21/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class StartGameScene: SKScene {
    
    var playButton: MenuButton!
    var optionsButton: MenuButton!
    var manualButton: MenuButton!
   
    override func didMoveToView(view: SKView) {
        //background
        backgroundColor = SKColor.blackColor()
        let starField = SKEmitterNode(fileNamed: "StarField")
        starField.advanceSimulationTime(10.0)
        starField.position = CGPointMake(size.width / 2, size.height)
        starField.zPosition = -1000
        addChild(starField)
        
        //game title
        let titleText = TitleText(text: "harvester", xPos: size.width / 2, yPos: size.height - 200)
        addChild(titleText)
        
        //buttons
        self.playButton = MenuButton(icon: "Phoenix", label: "PLAY", name: "playButton", xPos: size.width / 2, yPos: size.height / 2, enabled: true)
        addChild(self.playButton)
        
        self.optionsButton = MenuButton(icon: "Phoenix", label: "OPTIONS", name: "optionsButton", xPos: playButton.position.x - playButton.size.width / 2, yPos: playButton.position.y - playButton.size.height / 1.33, enabled: true)
        addChild(self.optionsButton)
        
        self.manualButton = MenuButton(icon: "Phoenix", label: "MANUAL", name: "manualButton", xPos: playButton.position.x + playButton.size.width / 2, yPos: playButton.position.y - playButton.size.height / 1.33, enabled: true)
        addChild(self.manualButton)
        
        //fade in
        starField.alpha = 0
        starField.runAction(SKAction.fadeInWithDuration(1.0))
        titleText.alpha = 0
        titleText.runAction(SKAction.fadeInWithDuration(2.0))
        playButton.alpha = 0
        playButton.runAction(SKAction.fadeInWithDuration(3.0))
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            if(touchedNode.name == "playButton") {
                playButton.zPosition = 1000
                playButton.animate()
                
                let gameScene = GameScene(size: size)
                gameScene.scaleMode = scaleMode
                let transitionType = SKTransition.flipHorizontalWithDuration(1.0)
                view?.presentScene(gameScene,transition: transitionType)
            }
        }
    }
    
}


