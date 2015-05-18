//
//  GameOverScene.swift
//  SpaceInvaders
//
//  Created by Student on 5/5/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit
import Social

class GameOverScene: MenuScene {
    
    var text: [HUDText] = []
    var replayButton: MenuButton!
    var shareButton: MenuButton!
    var backButton: MenuButton!
    
    override func didMoveToView(view: SKView) {
        //add stat text
        addText(
            "Score: \(gameData.score)",
            xPos: size.width / 2,
            yPos: self.titleText.position.y - 100
        )
        
        //add buttons
        self.replayButton = MenuButton(
            icon: "Phoenix",
            label: "REPLAY",
            name: "replayButton",
            xPos: size.width / 2 - 100.5,
            yPos: size.height / 2 - 110,
            enabled: true
        )
        self.buttons.append(self.replayButton)
        self.addChild(self.replayButton)
        
        self.shareButton = MenuButton(
            icon: "Phoenix",
            label: "SHARE",
            name: "shareButton",
            xPos: size.width / 2 + 100.5,
            yPos: self.replayButton.position.y,
            enabled: true
        )
        self.buttons.append(self.shareButton)
        addChild(self.shareButton)
        
        self.backButton = MenuButton(
            icon: "Phoenix",
            label: "BACK",
            name: "backButton",
            xPos: size.width / 2,
            yPos: replayButton.position.y - replayButton.size.height / 1.33,
            enabled: true
        )
        self.buttons.append(self.backButton)
        addChild(self.backButton)
        
        //display menu
        fadeIn()
    }
    
    override func fadeIn() {
        self.starField.alpha = 0
        self.titleText.alpha = 0
        for (var i = 0; i < self.buttons.count; i++) {
            self.buttons[i].alpha = 0
            self.buttons[i].enabled = false
        }
        
        let fadeIn = SKAction.fadeInWithDuration(1.0)
        self.starField.runAction(fadeIn, completion: {
            self.titleText.runAction(fadeIn, completion: {
                for (var i = 0; i < self.text.count; i++) {
                    self.text[i].runAction(fadeIn)
                }
                
                for (var i = 0; i < self.buttons.count; i++) {
                    self.buttons[i].runAction(fadeIn, completion: {
                        for (var i = 0; i < self.buttons.count; i++) {
                            self.buttons[i].enabled = true
                        }
                    })
                }
            })
        })
    }
    
    func addText(text: String, xPos: CGFloat, yPos: CGFloat) {
        let t = HUDText(text: text, xPos: xPos, yPos: yPos)
        t.horizontalAlignmentMode = .Center
        t.alpha = 0
        self.text.append(t)
        self.addChild(t)
    }
    
    func fadeOutText() {
        for (var i = 0; i < self.text.count; i++) {
            self.text[i].runAction(SKAction.fadeOutWithDuration(1.0))
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            if (touchedNode.name == "replayButton" && self.replayButton.enabled) {
                buttonClicked(self.replayButton, scene: GameScene(size: self.size))
                fadeOutText()
            }
            else if (touchedNode.name == "shareButton" && self.shareButton.enabled) {
                //TODO: share screenshot of results
                UIGraphicsBeginImageContext(self.size)
                self.view?.layer.renderInContext(UIGraphicsGetCurrentContext())
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                gameData.scoreImage = image
                NSNotificationCenter.defaultCenter().postNotificationName("share", object: nil)
                
            }
                
            else if (touchedNode.name == "backButton" && self.backButton.enabled) {
                buttonClicked(self.backButton, scene: GameModeScene(size: self.size, title: "mode"))
                fadeOutText()
            }
        }
    }
    
}