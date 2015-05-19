//
//  GameModeScene.swift
//  SpaceInvaders
//
//  Created by Student on 5/11/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class GameModeScene: MenuScene {
    
    var soloButton: MenuButton!
    var coopButton: MenuButton!
    var storeButton: MenuButton!
    var backButton: MenuButton!
    var scoresButton: MenuButton!
    
    override func didMoveToView(view: SKView) {
        
        //add buttons
        self.soloButton = MenuButton(
            icon: "solo",
            label: "SOLO",
            name: "soloButton",
            xPos: size.width / 2 - 100.5,
            yPos: size.height / 2,
            enabled: true
        )
        self.buttons.append(self.soloButton)
        self.addChild(self.soloButton)
        
        self.coopButton = MenuButton(
            icon: "coop",
            label: "CO-OP",
            name: "coopButton",
            xPos: size.width / 2 + 100.5,
            yPos: size.height / 2,
            enabled: false
        )
        self.buttons.append(self.coopButton)
        self.addChild(self.coopButton)
        
        self.storeButton = MenuButton(
            icon: "store",
            label: "STORE",
            name: "storeButton",
            xPos: size.width / 2,
            yPos: size.height / 2 - self.soloButton.size.height / 1.33,
            enabled: false
        )
        self.buttons.append(self.storeButton)
        self.addChild(self.storeButton)
        
        self.backButton = MenuButton(
            icon: "back",
            label: "BACK",
            name: "backButton",
            xPos: size.width / 2 - self.storeButton.size.width - 0.5,
            yPos: size.height / 2 - self.soloButton.size.height / 1.33,
            enabled: true)
        self.buttons.append(self.backButton)
        self.addChild(self.backButton)
        
        self.scoresButton = MenuButton(
            icon: "trophy",
            label: "SCORES",
            name: "scoresButton",
            xPos: size.width / 2 + self.storeButton.size.width + 0.5,
            yPos: size.height / 2 - self.soloButton.size.height / 1.33,
            enabled: true
        )
        self.buttons.append(self.scoresButton)
        self.addChild(self.scoresButton)
        
        //display menu
        fadeIn()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            if (touchedNode.name == "soloButton" && soloButton.enabled) {
                buttonClicked(self.soloButton, scene: GameScene(size: self.size))
            }
            else if (touchedNode.name == "backButton" && backButton.enabled) {
                buttonClicked(self.backButton, scene: StartGameScene(size: self.size, title: "harvester"))
            }
            else if (touchedNode.name == "scoresButton" && scoresButton.enabled) {
                buttonClicked(self.scoresButton, scene: HighScoresScene(size: self.size, title: "highscores"))
            }
            //TODO: Implement other scene buttons...
        }
    }
    
}



