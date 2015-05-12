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
        starField.advanceSimulationTime(15.0)
        starField.position = CGPointMake(size.width / 2, size.height + 100)
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
        titleText.alpha = 0
        self.playButton.alpha = 0
        self.optionsButton.alpha = 0
        self.manualButton.alpha = 0
        
        let fadeIn = SKAction.fadeInWithDuration(1.0)
        starField.runAction(fadeIn, completion: {
            titleText.runAction(fadeIn, completion: {
                self.playButton.runAction(fadeIn)
                self.optionsButton.runAction(fadeIn)
                self.manualButton.runAction(fadeIn)
            })
        })
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            if (touchedNode.name == "playButton" && self.playButton.enabled) {
                self.playButton.enabled = false
                self.playButton.zPosition = 1000
                self.playButton.highlight()
                
                self.playButton.fill.runAction(SKAction.colorizeWithColor(SKColor.redColor(), colorBlendFactor: 1.0, duration: 0.25))
                self.playButton.runAction(SKAction.scaleBy(1.25, duration: 0.25), completion: {
                    //go to game mode select scene
                    let gameModeScene = GameModeScene(size: self.size)
                    gameModeScene.scaleMode = self.scaleMode
                    
                    let transition = SKTransition.fadeWithDuration(1.0)
                    self.view?.presentScene(gameModeScene, transition: transition)
                })
                self.optionsButton.runAction(SKAction.fadeOutWithDuration(0.25))
                self.manualButton.runAction(SKAction.fadeOutWithDuration(0.25))
            }
            else if (touchedNode.name == "optionsButton" && self.optionsButton.enabled) {
                self.optionsButton.enabled = false
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
            else if (touchedNode.name == "manualButton" && self.manualButton.enabled) {
                self.manualButton.enabled = false
                self.manualButton.zPosition = 1000
                self.manualButton.highlight()
                
                self.manualButton.fill.runAction(SKAction.colorizeWithColor(SKColor.redColor(), colorBlendFactor: 1.0, duration: 0.25))
                self.manualButton.runAction(SKAction.scaleBy(1.25, duration: 0.25), completion: {
                    let manualScene = ManualScene(size: self.size)
                    manualScene.scaleMode = self.scaleMode
                    
                    let transition = SKTransition.fadeWithDuration(1.0)
                    self.view?.presentScene(manualScene, transition: transition)
                })
                self.playButton.runAction(SKAction.fadeOutWithDuration(0.25))
                self.optionsButton.runAction(SKAction.fadeOutWithDuration(0.25))
            }
        }
    }
    
}


