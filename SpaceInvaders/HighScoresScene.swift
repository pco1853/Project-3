//
//  HighScoresScene.swift
//  SpaceInvaders
//
//  Created by Student on 5/19/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class HighScoresScene: MenuScene {
    
    var text: [HUDText] = []
    var backButton: MenuButton!
    
    override func didMoveToView(view: SKView) {
     
        //add buttons
        self.backButton = MenuButton(
            icon: "back",
            label: "BACK",
            name: "backButton",
            xPos: size.width / 2,
            yPos: size.height / 2 - 410,
            enabled: true
        )
        
        self.backButton.xScale = 0.7
        self.backButton.yScale = 0.7
        
        self.buttons.append(self.backButton)
        self.addChild(self.backButton)
        
        displayHighScores()
        //display menu
        fadeIn()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            if (touchedNode.name == "backButton" && backButton.enabled) {
                buttonClicked(self.backButton, scene: GameModeScene(size: self.size, title: "mode"))
            }
        }
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
    
    func displayHighScores() {
        var yPos = self.titleText.position.y - 110
        
        if(gameData.highScores.count == 0)
        {
            addText("No highscores registered yet",
                xPos: size.width / 2,
                yPos: size.height / 2
            )
        }
        else
        {
            //print out all highscores in the list
            for (var i = 0; i < gameData.highScores.count; i++)
            {
                addText(String("\(i + 1) :"),
                    xPos: size.width / 2 - 20,
                    yPos: yPos
                )
            
                addText(String(gameData.highScores[i]),
                    xPos: size.width / 2 + 20,
                    yPos: yPos
                )
                yPos -= 50
            }
        }
    
    }
    
    func addText(text: String, xPos: CGFloat, yPos: CGFloat) {
        let t = HUDText(text: text, xPos: xPos, yPos: yPos)
        t.horizontalAlignmentMode = .Center
        t.alpha = 0
        self.text.append(t)
        self.addChild(t)
    }
    
    
}