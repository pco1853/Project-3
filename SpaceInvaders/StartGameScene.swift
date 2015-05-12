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
    var manualButton: MenuButton!
   
    override func didMoveToView(view: SKView) {
        //add buttons
        self.playButton = MenuButton(icon: "Phoenix", label: "PLAY", name: "playButton", xPos: size.width / 2, yPos: size.height / 2, enabled: true)
        self.buttons.append(self.playButton)
        addChild(self.playButton)
        
        self.optionsButton = MenuButton(icon: "Phoenix", label: "OPTIONS", name: "optionsButton", xPos: playButton.position.x - playButton.size.width / 2, yPos: playButton.position.y - playButton.size.height / 1.33, enabled: true)
        self.buttons.append(self.optionsButton)
        addChild(self.optionsButton)
        
        self.manualButton = MenuButton(icon: "Phoenix", label: "MANUAL", name: "manualButton", xPos: playButton.position.x + playButton.size.width / 2, yPos: playButton.position.y - playButton.size.height / 1.33, enabled: true)
        self.buttons.append(self.manualButton)
        addChild(self.manualButton)
        
        //fade in
        fadeIn()
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            if (touchedNode.name == "playButton" && self.playButton.enabled) {
                buttonClicked(self.playButton, scene: GameModeScene(size: self.size, title: "mode select"))
            }
            else if (touchedNode.name == "optionsButton" && self.optionsButton.enabled) {
                buttonClicked(self.optionsButton, scene: OptionsScene(size: self.size, title: "options"))
            }
            else if (touchedNode.name == "manualButton" && self.manualButton.enabled) {
                buttonClicked(self.manualButton, scene: ManualScene(size: self.size, title: "manual"))
            }
        }
    }
    
}


