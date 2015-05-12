//
//  StartGameScene.swift
//  SpaceInvaders
//
//  Created by Student on 4/21/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class ManualScene: SKScene {
    
    var backButton: MenuButton!
    
    override func didMoveToView(view: SKView) {
        //background
        backgroundColor = SKColor.blackColor()
        let starField = SKEmitterNode(fileNamed: "StarField")
        starField.advanceSimulationTime(15.0)
        starField.position = CGPointMake(size.width / 2, size.height + 100)
        starField.zPosition = -1000
        addChild(starField)
        
        //game title
        let titleText = TitleText(text: "manual", xPos: size.width / 2, yPos: size.height - 200)
        addChild(titleText)
        
        //TODO: display instructions
        
        //buttons
        self.backButton = MenuButton(icon: "Phoenix", label: "BACK", name: "backButton", xPos: size.width / 2, yPos: size.height / 2, enabled: true)
        addChild(self.backButton)
        
        //fade in
        starField.alpha = 0
        titleText.alpha = 0
        self.backButton.alpha = 0
        
        let fadeIn = SKAction.fadeInWithDuration(1.0)
        starField.runAction(fadeIn, completion: {
            titleText.runAction(fadeIn, completion: {
                self.backButton.runAction(fadeIn)
            })
        })
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            if (touchedNode.name == "backButton" && self.backButton.enabled) {
                self.backButton.enabled = false
                self.backButton.zPosition = 1000
                self.backButton.highlight()
                self.backButton.fill.runAction(SKAction.colorizeWithColor(SKColor.redColor(), colorBlendFactor: 1.0, duration: 0.25))
                self.backButton.runAction(SKAction.scaleBy(1.25, duration: 0.25), completion: {
                    //go to start game scene
                    let startGameScene = StartGameScene(size: self.size)
                    startGameScene.scaleMode = self.scaleMode
                    
                    let transition = SKTransition.fadeWithDuration(1.0)
                    self.view?.presentScene(startGameScene, transition: transition)
                })
            }
        }
    }
    
}



