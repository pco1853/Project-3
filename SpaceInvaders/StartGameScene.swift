//
//  StartGameScene.swift
//  SpaceInvaders
//
//  Created by Student on 4/21/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class StartGameScene: MenuScene {
    
    var playButton: MenuButton!
    var optionsButton: MenuButton!
    var creditsButton: MenuButton!
   
    override func didMoveToView(view: SKView) {
        //add menu sound
        sharedAudio.playBackgroundSound("laser.mp3", loops: -1)
        
        //add buttons
        self.playButton = MenuButton(
            icon: "Phoenix",
            label: "PLAY",
            name: "playButton",
            xPos: size.width / 2,
            yPos: size.height / 2,
            enabled: true
        )
        self.buttons.append(self.playButton)
        self.addChild(self.playButton)
        
        self.optionsButton = MenuButton(
            icon: "Phoenix",
            label: "OPTIONS",
            name: "optionsButton",
            xPos: size.width / 2 - 100.5,
            yPos: playButton.position.y - playButton.size.height / 1.33,
            enabled: true
        )
        self.buttons.append(self.optionsButton)
        self.addChild(self.optionsButton)
        
        self.creditsButton = MenuButton(
            icon: "icon_credits",
            label: "CREDITS",
            name: "creditsButton",
            xPos: size.width / 2 + 100.5,
            yPos: playButton.position.y - playButton.size.height / 1.33,
            enabled: true
        )
        self.buttons.append(self.creditsButton)
        self.addChild(self.creditsButton)
        
        //display menu
        fadeIn()
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            if (touchedNode.name == "playButton" && self.playButton.enabled) {
                buttonClicked(self.playButton, scene: GameModeScene(size: self.size, title: "mode"))
            }
            else if (touchedNode.name == "optionsButton" && self.optionsButton.enabled) {
                buttonClicked(self.optionsButton, scene: OptionsScene(size: self.size, title: "options"))
            }
            else if (touchedNode.name == "creditsButton" && self.creditsButton.enabled) {
                buttonClicked(self.creditsButton, scene: CreditsScene(size: self.size, title: "credits"))
            }
        }
    }
    
}


