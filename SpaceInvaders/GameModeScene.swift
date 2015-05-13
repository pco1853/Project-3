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
        self.soloButton = MenuButton(icon: "Phoenix", label: "SOLO", name: "soloButton", xPos: size.width / 2 - 100.5, yPos: size.height / 2, enabled: true)
        self.buttons.append(self.soloButton)
        addChild(self.soloButton)
        
        self.coopButton = MenuButton(icon: "Phoenix", label: "CO-OP", name: "coopButton", xPos: size.width / 2 + 100.5, yPos: size.height / 2, enabled: true)
        self.buttons.append(self.coopButton)
        addChild(self.coopButton)
        
        self.storeButton = MenuButton(icon: "Phoenix", label: "STORE", name: "storeButton", xPos: size.width / 2, yPos: size.height / 2 - self.soloButton.size.height / 1.33, enabled: true)
        self.buttons.append(self.storeButton)
        addChild(self.storeButton)
        
        self.backButton = MenuButton(icon: "Phoenix", label: "BACK", name: "backButton", xPos: size.width / 2 - self.storeButton.size.width - 0.5, yPos: size.height / 2 - self.soloButton.size.height / 1.33, enabled: true)
        self.buttons.append(self.backButton)
        addChild(self.backButton)
        
        self.scoresButton = MenuButton(icon: "Phoenix", label: "SCORES", name: "scoresButton", xPos: size.width / 2 + self.storeButton.size.width + 0.5, yPos: size.height / 2 - self.soloButton.size.height / 1.33, enabled: true)
        self.buttons.append(self.scoresButton)
        addChild(self.scoresButton)
        
        //fade in
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
                self.buttons.removeAll(keepCapacity: false)
                buttonClicked(self.backButton, scene: StartGameScene(size: self.size, title: "harvester"))
            }
            
            //TODO: Implement other scene buttons...
        }
    }
    
}


