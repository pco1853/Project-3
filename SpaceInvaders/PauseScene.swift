//
//  PauseScene.swift
//  SpaceInvaders
//
//  Created by Student on 5/17/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class PauseScene: MenuScene {
    
    var text: [HUDText] = []
    var unpauseButton: MenuButton!
    var quitButton: MenuButton!
    var mainMenu: StartGameScene!
    var newView: SKView!
    
    init(size: CGSize, title: String, view: SKView) {
        
        super.init(size: size, title: title)
        self.newView = view
        self.mainMenu = StartGameScene(size: CGSizeMake(768, 1024), title: "harvester")
        //add buttons
        self.unpauseButton = MenuButton(
            icon: "play",
            label: "UNPAUSE",
            name: "unpauseButton",
            xPos: self.size.width / 2 - 100.5,
            yPos: self.size.height / 2 - 110,
            enabled: true
        )
        self.unpauseButton.fill.color = UIColor.grayColor()
        self.unpauseButton.fill.alpha = 0.5
        self.unpauseButton.colorBlendFactor = 1.0
        self.unpauseButton.zPosition = 1000
        self.buttons.append(self.unpauseButton)
        self.addChild(self.unpauseButton)
        
        self.quitButton = MenuButton(
            icon: "quit",
            label: "QUIT",
            name: "quitButton",
            xPos: self.size.width / 2 + 100.5,
            yPos: self.unpauseButton.position.y,
            enabled: true
        )
        self.quitButton.fill.color = UIColor.grayColor()
        self.quitButton.fill.alpha = 0.5
        self.quitButton.colorBlendFactor = 1.0
        self.quitButton.zPosition = 1000
        self.buttons.append(self.quitButton)
        self.addChild(self.quitButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            
            let touchLocation = touch.locationInNode(self.parent)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            if (touchedNode.name == "unpauseButton" && self.unpauseButton.enabled) {
                
                self.unpauseButton.highlight()
                var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("unPause"), userInfo: nil, repeats: false)
                
            }
            else if (touchedNode.name == "quitButton" && self.quitButton.enabled) {
                //TODO: share screenshot of results
                
                self.quitButton.highlight()
                var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("quit"), userInfo: nil, repeats: false)
                
            }
            
        }
    }
    
    func unPause()
    {
        var parent = self.parent as GameScene
        parent.addChild(parent.pauseButton)
        parent.pauseButton.enabled = true
        parent.paused = false
        self.removeFromParent()
    }
    
    func quit()
    {
        self.newView!.presentScene(self.mainMenu, transition: SKTransition.fadeWithDuration(0.4))
    }
}
