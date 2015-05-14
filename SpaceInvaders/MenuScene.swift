//
//  GameModeScene.swift
//  SpaceInvaders
//
//  Created by Student on 5/11/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class MenuScene: SKScene {
    
    var starField: SKEmitterNode!
    var titleText: TitleText!
    var buttons: [MenuButton] = []
    
    init(size: CGSize, title: String) {
        super.init(size: size)
        
        self.backgroundColor = SKColor.blackColor()
        
        self.starField = SKEmitterNode(fileNamed: "StarField")
        self.starField.position = CGPointMake(size.width / 2, size.height + 100)
        self.starField.zPosition = -1000
        self.starField.advanceSimulationTime(15.0)
        addChild(self.starField)
        
        self.titleText = TitleText(text: title, xPos: size.width / 2, yPos: size.height - 200)
        addChild(self.titleText)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fadeIn() {
        starField.alpha = 0
        titleText.alpha = 0
        for (var i = 0; i < self.buttons.count; i++) {
            self.buttons[i].alpha = 0
            self.buttons[i].enabled = false
        }
        
        let fadeIn = SKAction.fadeInWithDuration(1.0)
        self.starField.runAction(fadeIn, completion: {
            self.titleText.runAction(fadeIn, completion: {
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
    
    func buttonClicked(button: MenuButton, scene: SKScene) {
        if (button.enabled) {
            button.enabled = false
            button.zPosition = 1000
            button.highlight()
            
            let fadeOut = SKAction.fadeOutWithDuration(0.25)
            for (var i = 0; i < self.buttons.count; i++) {
                if (self.buttons[i].name != button.name) {
                    self.buttons[i].enabled = false
                    self.buttons[i].runAction(fadeOut)
                }
            }
            
            button.fill.runAction(SKAction.fadeAlphaTo(1.0, duration: 0.25))
            button.runAction(SKAction.scaleBy(1.25, duration: 0.25), completion: {
                //go to scene
                scene.scaleMode = self.scaleMode
                let transition = SKTransition.fadeWithDuration(1.0)
                self.view?.presentScene(scene, transition: transition)
            })
        }
    }
    
    func buttonClicked(button: MenuButton, completion block: (() -> Void)!) {
        if (button.enabled) {
            button.enabled = false
            button.zPosition = 1000
            button.highlight()
            
            let fadeOut = SKAction.fadeOutWithDuration(0.25)
            for (var i = 0; i < buttons.count; i++) {
                if (buttons[i].name != button.name) {
                    self.buttons[i].enabled = false
                    buttons[i].runAction(fadeOut)
                }
            }
            
            button.fill.runAction(SKAction.fadeAlphaTo(1.0, duration: 0.25))
            button.runAction(SKAction.scaleBy(1.25, duration: 0.25), completion: {
                button.runAction(fadeOut, completion: {
                    block()
                })
            })
        }
    }
    
}



