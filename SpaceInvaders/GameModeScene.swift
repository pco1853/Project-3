//
//  GameModeScene.swift
//  SpaceInvaders
//
//  Created by Student on 5/11/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class GameModeScene: SKScene {
    
    var campaignButton: MenuButton!
    var coopButton: MenuButton!
    var storeButton: MenuButton!
    var backButton: MenuButton!
    var scoresButton: MenuButton!
    
    override func didMoveToView(view: SKView) {
        //background
        backgroundColor = SKColor.blackColor()
        let starField = SKEmitterNode(fileNamed: "StarField")
        starField.advanceSimulationTime(10.0)
        starField.position = CGPointMake(size.width / 2, size.height)
        starField.zPosition = -1000
        addChild(starField)
        
        //game title
        let titleText = TitleText(text: "mode select", xPos: size.width / 2, yPos: size.height - 200)
        addChild(titleText)
        
        //buttons
        self.campaignButton = MenuButton(icon: "Phoenix", label: "CAMPAIGN", name: "campaignButton", xPos: size.width / 2 - 100, yPos: size.height / 2, enabled: true)
        addChild(self.campaignButton)
        
        self.coopButton = MenuButton(icon: "Phoenix", label: "CO OP", name: "coopButton", xPos: size.width / 2 + 100, yPos: size.height / 2, enabled: true)
        addChild(self.coopButton)
        
        self.storeButton = MenuButton(icon: "Phoenix", label: "STORE", name: "storeButton", xPos: size.width / 2, yPos: size.height / 2 - self.campaignButton.size.height / 1.33, enabled: true)
        addChild(self.storeButton)
        
        self.backButton = MenuButton(icon: "Phoenix", label: "BACK", name: "backButton", xPos: size.width / 2 - self.storeButton.size.width, yPos: size.height / 2 - self.campaignButton.size.height / 1.33, enabled: true)
        addChild(self.backButton)
        
        self.scoresButton = MenuButton(icon: "Phoenix", label: "SCORES", name: "scoresButton", xPos: size.width / 2 + self.storeButton.size.width, yPos: size.height / 2 - self.campaignButton.size.height / 1.33, enabled: true)
        addChild(self.scoresButton)
        
        //fade in
        starField.alpha = 0
        titleText.alpha = 0
        self.campaignButton.alpha = 0
        self.coopButton.alpha = 0
        self.storeButton.alpha = 0
        self.backButton.alpha = 0
        self.scoresButton.alpha = 0
        
        let fadeIn = SKAction.fadeInWithDuration(1.0)
        starField.runAction(fadeIn, completion: {
            titleText.runAction(fadeIn, completion: {
                self.campaignButton.runAction(fadeIn)
                self.coopButton.runAction(fadeIn)
                self.storeButton.runAction(fadeIn)
                self.backButton.runAction(fadeIn)
                self.scoresButton.runAction(fadeIn)
            })
        })
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            if (touchedNode.name == "backButton") {
                self.backButton.zPosition = 1000
                self.backButton.highlight()
                self.backButton.fill.runAction(SKAction.colorizeWithColor(SKColor.redColor(), colorBlendFactor: 1.0, duration: 0.25))
                self.backButton.runAction(SKAction.scaleBy(1.25, duration: 0.25), completion: {
                    //go to start scene
                    let startGameScene = StartGameScene(size: self.size)
                    startGameScene.scaleMode = self.scaleMode
                    
                    let transition = SKTransition.fadeWithDuration(1.0)
                    self.view?.presentScene(startGameScene, transition: transition)
                })
                self.campaignButton.runAction(SKAction.fadeOutWithDuration(0.25))
                self.coopButton.runAction(SKAction.fadeOutWithDuration(0.25))
                self.scoresButton.runAction(SKAction.fadeOutWithDuration(0.25))
                self.storeButton.runAction(SKAction.fadeOutWithDuration(0.25))
            }
            
            /*
            if (touchedNode.name == "playButton") {
                self.playButton.zPosition = 1000
                self.playButton.highlight()
                self.playButton.fill.runAction(SKAction.colorizeWithColor(SKColor.redColor(), colorBlendFactor: 1.0, duration: 0.25))
                self.playButton.runAction(SKAction.scaleBy(1.25, duration: 0.25), completion: {
                    //go to game mode select scene
                    /*
                    let gameModeScene = gameModeScene(size: size)
                    gameModeScene.scaleMode = scaleMode
                    
                    let transition = SKTransition.fadeWithDuration(1.0)
                    view?.presentScene(gameModeScene, transition: transition)
                    */
                })
                self.optionsButton.runAction(SKAction.fadeOutWithDuration(0.25))
                self.manualButton.runAction(SKAction.fadeOutWithDuration(0.25))
            }
                /*
            else if (touchedNode.name == "optionsButton") {
                self.optionsButton.zPosition = 1000
                self.optionsButton.highlight()
                self.optionsButton.fill.runAction(SKAction.colorizeWithColor(SKColor.redColor(), colorBlendFactor: 1.0, duration: 0.25))
                self.optionsButton.runAction(SKAction.scaleBy(1.25, duration: 0.25), completion: {
                    /*TODO:
                    let optionsScene = OptionsScene(size: size)
                    optionsScene.scaleMode = scaleMode
                    
                    let transition = SKTransition.fadeWithDuration(1.0)
                    view?.presentScene(optionsScene, transition: transition)
                    */
                })
                self.playButton.runAction(SKAction.fadeOutWithDuration(0.25))
                self.manualButton.runAction(SKAction.fadeOutWithDuration(0.25))
            }
            else if (touchedNode.name == "manualButton") {
                self.manualButton.zPosition = 1000
                self.manualButton.highlight()
                self.manualButton.fill.runAction(SKAction.colorizeWithColor(SKColor.redColor(), colorBlendFactor: 1.0, duration: 0.25))
                self.manualButton.runAction(SKAction.scaleBy(1.25, duration: 0.25), completion: {
                    /*TODO:
                    let manualScene = ManualScene(size: size)
                    manualScene = scaleMode
                    
                    let transition = SKTransition.fadeWithDuration(1.0)
                    view?.presentScene(manualScene, transition: transition)
                    */
                })
                self.playButton.runAction(SKAction.fadeOutWithDuration(0.25))
                self.optionsButton.runAction(SKAction.fadeOutWithDuration(0.25))
            }*/
        }
    }
    
}



