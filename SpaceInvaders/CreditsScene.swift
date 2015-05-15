//
//  StartGameScene.swift
//  SpaceInvaders
//
//  Created by Student on 4/21/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class CreditsScene: MenuScene {
    
    var text: [HUDText] = []
    var backButton: MenuButton!
    
    override func didMoveToView(view: SKView) {
        //add text
        addText("Harvester",
            xPos: size.width / 2,
            yPos: self.titleText.position.y - 100
        )
        addText("Created by Derrick Hunt, Pete O'Neal & Jason Peretz",
            xPos: size.width / 2,
            yPos: self.titleText.position.y - 160
        )
        addText("Version 0.5",
            xPos: size.width / 2,
            yPos: self.titleText.position.y - 200
        )
        addText("All rights reserved",
            xPos: size.width / 2,
            yPos: self.titleText.position.y - 240
        )
        
        //add buttons
        self.backButton = MenuButton(
            icon: "Phoenix",
            label: "BACK",
            name: "backButton",
            xPos: size.width / 2,
            yPos: size.height / 2 - 110,
            enabled: true
        )
        self.buttons.append(self.backButton)
        self.addChild(self.backButton)
        
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
            
            if (touchedNode.name == "backButton" && self.backButton.enabled) {
                buttonClicked(self.backButton, scene: StartGameScene(size: self.size, title: "harvester"))
                fadeOutText()
            }
        }
    }
    
}



