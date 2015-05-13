//
//  StartGameScene.swift
//  SpaceInvaders
//
//  Created by Student on 4/21/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class ManualScene: MenuScene {
    
    var backButton: MenuButton!
    
    override func didMoveToView(view: SKView) {
        
        //TODO: display instructions
        
        //add buttons
        self.backButton = MenuButton(icon: "Phoenix", label: "BACK", name: "backButton", xPos: size.width / 2, yPos: size.height / 2, enabled: true)
        self.buttons.append(self.backButton)
        addChild(self.backButton)
        
        //fade in
        fadeIn()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            if (touchedNode.name == "backButton" && self.backButton.enabled) {
                self.buttons.removeAll(keepCapacity: false)
                buttonClicked(self.backButton, scene: StartGameScene(size: self.size, title: "harvester"))
            }
        }
    }
    
}



