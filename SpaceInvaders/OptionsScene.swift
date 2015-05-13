//
//  OptionsScene.swift
//  SpaceInvaders
//
//  Created by Student on 5/12/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class OptionsScene: MenuScene {
    
    var backButton: MenuButton!
    var tiltButton: MenuButton!
    var virtualButton: MenuButton!
    var tiltDescription: SKLabelNode!
    var tiltDescription2: SKLabelNode!
    var tiltDescription3: SKLabelNode!
    var virtualDescription: SKLabelNode!
    var virtualDescription2: SKLabelNode!
    var virtualDescription3: SKLabelNode!
    let fadeIn = SKAction.fadeInWithDuration(0.1)
    let fadeOut = SKAction.fadeOutWithDuration(0.0)
    
    override func didMoveToView(view: SKView)
    {
        
        self.backButton = MenuButton(icon: "Phoenix", label: "BACK", name: "backButton", xPos: size.width / 2 , yPos: size.height / 2 - 400, enabled: true)
        self.backButton.xScale = 0.5
        self.backButton.yScale = 0.5
        self.buttons.append(self.backButton)
        addChild(self.backButton)
        
        self.tiltButton = MenuButton(icon: "Phoenix", label: "TILT", name: "tiltControls", xPos: size.width / 2 - 180, yPos: size.height / 2 + 100, enabled: true)
        self.buttons.append(self.tiltButton)
        addChild(self.tiltButton)
        
        self.virtualButton = MenuButton(icon: "Phoenix", label: "VIRTUAL", name: "virtualControls", xPos: size.width / 2 - 180, yPos: size.height / 2 - 200, enabled: true)
        self.buttons.append(self.virtualButton)
        addChild(self.virtualButton)
        
        //fades in buttons and title text
        fadeIn()
        
        setUpButtonDescriptions()
    }
    
    //SKLabel node only supports 1 line of text... so each line of a description has to be its own labelNode
    func setUpButtonDescriptions()
    {
        self.tiltDescription = SKLabelNode(text: "Use the accelermoter to move.")
        self.tiltDescription.position = CGPointMake(size.width / 2 + 120, size.height / 2 + 137)
        self.tiltDescription.fontName = "SquareFont"
        self.tiltDescription.fontColor = UIColor.whiteColor()
        self.tiltDescription.fontSize = 22.0
        
        self.tiltDescription2 = SKLabelNode(text: "Tap the screen to shoot.")
        self.tiltDescription2.position = CGPointMake(size.width / 2 + 85, size.height / 2 + 90)
        self.tiltDescription2.fontName = "SquareFont"
        self.tiltDescription2.fontColor = UIColor.whiteColor()
        self.tiltDescription2.fontSize = 22.0
        
        self.tiltDescription3 = SKLabelNode(text: "Swipe up to harvest.")
        self.tiltDescription3.position = CGPointMake(size.width / 2 + 62, size.height / 2 + 45)
        self.tiltDescription3.fontName = "SquareFont"
        self.tiltDescription3.fontColor = UIColor.whiteColor()
        self.tiltDescription3.fontSize = 22.0
        
        
        self.virtualDescription = SKLabelNode(text: "Left and Right arrows to move")
        self.virtualDescription.position = CGPointMake(size.width / 2 + 118, size.height / 2 - 165)
        self.virtualDescription.fontName = "SquareFont"
        self.virtualDescription.fontColor = UIColor.whiteColor()
        self.virtualDescription.fontSize = 22.0
        
        
        self.virtualDescription2 = SKLabelNode(text: "Right button to shoot.")
        self.virtualDescription2.position = CGPointMake(size.width / 2 + 71, size.height / 2 - 210)
        self.virtualDescription2.fontName = "SquareFont"
        self.virtualDescription2.fontColor = UIColor.whiteColor()
        self.virtualDescription2.fontSize = 22.0
        
        
        self.virtualDescription3 = SKLabelNode(text: "Left button to harvest.")
        self.virtualDescription3.position = CGPointMake(size.width / 2 + 79, size.height / 2 - 255)
        self.virtualDescription3.fontName = "SquareFont"
        self.virtualDescription3.fontColor = UIColor.whiteColor()
        self.virtualDescription3.fontSize = 22.0

        addChild(self.tiltDescription)
        addChild(self.tiltDescription2)
        addChild(self.tiltDescription3)
        
        addChild(self.virtualDescription)
        addChild(self.virtualDescription2)
        addChild(self.virtualDescription3)
        
        if(controlScheme == "Accelerometer Controls")
        {
            self.virtualButton.undoHighlight()
            self.tiltButton.highlight()
            
            self.virtualDescription.runAction(fadeOut)
            self.virtualDescription2.runAction(fadeOut)
            self.virtualDescription3.runAction(fadeOut)
            
            self.tiltDescription.runAction(fadeIn)
            self.tiltDescription2.runAction(fadeIn)
            self.tiltDescription3.runAction(fadeIn)
        }
        else if(controlScheme == "Virtual Controls")
        {
            self.tiltButton.undoHighlight()
            self.virtualButton.highlight()
            
            self.virtualDescription.runAction(fadeIn)
            self.virtualDescription2.runAction(fadeIn)
            self.virtualDescription3.runAction(fadeIn)
            
            self.tiltDescription.runAction(fadeOut)
            self.tiltDescription2.runAction(fadeOut)
            self.tiltDescription3.runAction(fadeOut)
        }

    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            if (touchedNode.name == "backButton" && self.backButton.enabled) {
                self.buttons.removeAll(keepCapacity: false)
                buttonClicked(self.backButton, scene: StartGameScene(size: self.size, title: "harvester"))
            }
            else if(touchedNode.name == "tiltControls")
            {
                self.virtualDescription.runAction(fadeOut)
                self.virtualDescription2.runAction(fadeOut)
                self.virtualDescription3.runAction(fadeOut)
                
                self.tiltDescription.runAction(fadeIn)
                self.tiltDescription2.runAction(fadeIn)
                self.tiltDescription3.runAction(fadeIn)
                
                self.virtualButton.undoHighlight()
                self.tiltButton.highlight()
                
                controlScheme = "Accelerometer Controls"
            }
            else if(touchedNode.name == "virtualControls")
            {
                
                self.tiltDescription.runAction(fadeOut)
                self.tiltDescription2.runAction(fadeOut)
                self.tiltDescription3.runAction(fadeOut)
                
                self.virtualDescription.runAction(fadeIn)
                self.virtualDescription2.runAction(fadeIn)
                self.virtualDescription3.runAction(fadeIn)
                
                self.tiltButton.undoHighlight()
                self.virtualButton.highlight()
                
                controlScheme = "Virtual Controls"
            }
        }
    }
    
}