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
    
    enum menuState { case DEFAULT, CONTROLS, SOUND }
    var currentState = menuState.DEFAULT
    
    var subtitle: HUDText!
    var text: [HUDText] = []
    
    //default buttons
    var controlsButton: MenuButton!
    var soundButton: MenuButton!
    var backButton: MenuButton!
    
    //control options
    var motionControlsButton: MenuButton!
    var virtualControlsButton: MenuButton!
    
    //sounds options
    var soundOnButton: MenuButton!
    var soundOffButton: MenuButton!
    
    override func didMoveToView(view: SKView)
    {
        showOptions()
        fadeIn()
    }
    
    func showOptions() {
        clearContent()
        
        //add default buttons
        self.controlsButton = MenuButton(icon: "Phoenix", label: "CONTROLS", name: "controlsButton", xPos: size.width / 2 - 100.5, yPos: size.height / 2, enabled: true)
        self.buttons.append(self.controlsButton)
        self.addChild(self.controlsButton)
        
        self.soundButton = MenuButton(icon: "Phoenix", label: "SOUND", name: "soundButton", xPos: size.width / 2 + 100.5, yPos: size.height / 2, enabled: true)
        self.buttons.append(self.soundButton)
        self.addChild(self.soundButton)
        
        self.backButton = MenuButton(icon: "Phoenix", label: "BACK", name: "backButton", xPos: size.width / 2, yPos: size.height / 2 - self.controlsButton.size.height / 1.33, enabled: true)
        self.buttons.append(self.backButton)
        self.addChild(self.backButton)
        
        //fade in
        if (currentState != .DEFAULT) { //check to avoid double fade on initial startup
            fadeInButtons()
        }
        
        //set state
        self.currentState = .DEFAULT
    }
    
    func showControlOptions() {
        clearContent()
        
        //add buttons
        self.motionControlsButton = MenuButton(icon: "", label: "MOTION", name: "motionControlsButton", xPos: size.width / 2 - 100.5, yPos: size.height / 2 - 110, enabled: true)
        self.buttons.append(self.motionControlsButton)
        addChild(self.motionControlsButton)
        
        self.virtualControlsButton = MenuButton(icon: "", label: "VIRTUAL", name: "virtualControlsButton", xPos: size.width / 2 + 100.5, yPos: size.height / 2 - 110, enabled: true)
        self.buttons.append(self.virtualControlsButton)
        addChild(self.virtualControlsButton)
        
        self.backButton = MenuButton(icon: "Phoenix", label: "BACK", name: "backButton", xPos: size.width / 2, yPos: size.height / 2 - self.motionControlsButton.size.height / 1.33 - 110, enabled: true)
        self.buttons.append(self.backButton)
        self.addChild(self.backButton)
        
        //add and fade in subtitle
        fadeInSubtitle("Control Scheme")
        
        //fade in buttons, determine which to highlight and text to display
        fadeInButtons()
        highlightControlOptions()
        
        //set state
        self.currentState = .CONTROLS
    }
    
    func showSoundOptions() {
        clearContent()
        
        //add buttons
        self.soundOnButton = MenuButton(icon: "", label: "ON", name: "soundOnButton", xPos: size.width / 2 - 100.5, yPos: size.height / 2, enabled: true)
        self.buttons.append(self.soundOnButton)
        addChild(self.soundOnButton)
        
        self.soundOffButton = MenuButton(icon: "", label: "OFF", name: "soundOffButton", xPos: size.width / 2 + 100.5, yPos: size.height / 2, enabled: true)
        self.buttons.append(self.soundOffButton)
        addChild(self.soundOffButton)
        
        self.backButton = MenuButton(icon: "Phoenix", label: "BACK", name: "backButton", xPos: size.width / 2, yPos: size.height / 2 - self.soundOnButton.size.height / 1.33, enabled: true)
        self.buttons.append(self.backButton)
        self.addChild(self.backButton)
        
        //fade in buttons
        fadeInButtons()
        
        //add and fade in subtitle
        fadeInSubtitle("Sound")
        highlightSoundOptions()
        
        //set state
        self.currentState = .SOUND
    }
    
    func highlightControlOptions() {
        //clear text
        for (var i = 0; i < self.text.count; i++) {
            self.text[i].removeFromParent()
        }
        self.text.removeAll()
        
        //remove highlights
        self.virtualControlsButton.undoHighlight()
        self.motionControlsButton.undoHighlight()
        
        //set highlights and text
        if (gameData.controlScheme == "motion") {
            self.motionControlsButton.highlight()
            fadeInText("Use the accelerometer to move", xPos: size.width / 2, yPos: self.subtitle.position.y - 60)
            fadeInText("Tap the screen to shoot", xPos: size.width / 2, yPos: self.subtitle.position.y - 100)
            fadeInText("Swipe up to harvest", xPos: size.width / 2, yPos: self.subtitle.position.y - 140)
        }
        else {
            self.virtualControlsButton.highlight()
            fadeInText("Use the arrow buttons to move", xPos: size.width / 2, yPos: self.subtitle.position.y - 60)
            fadeInText("Tap the right button to shoot", xPos: size.width / 2, yPos: self.subtitle.position.y - 100)
            fadeInText("Tap the left button to harvest", xPos: size.width / 2, yPos: self.subtitle.position.y - 140)
        }
    }
    
    func highlightSoundOptions() {
        //remove highlights
        self.soundOnButton.undoHighlight()
        self.soundOffButton.undoHighlight()
        
        //set highlights
        if (gameData.soundEnabled) {
            self.soundOnButton.highlight()
        }
        else {
            self.soundOffButton.highlight()
        }
    }
    
    func fadeInButtons() {
        //set invisible
        for (var i = 0; i < self.buttons.count; i++) {
            self.buttons[i].alpha = 0
        }
        
        //fade in
        let fadeIn = SKAction.fadeInWithDuration(1.0)
        for (var i = 0; i < self.buttons.count; i++) {
            self.buttons[i].enabled = false
            self.buttons[i].runAction(fadeIn, completion: {
                for (var i = 0; i < self.buttons.count; i++) {
                    self.buttons[i].enabled = true
                }
            })
        }
    }
    
    func fadeInSubtitle(subtitle: String) {
        self.subtitle = HUDText(text: subtitle, xPos: size.width / 2, yPos: self.titleText.position.y - 100)
        self.addChild(self.subtitle)
        self.subtitle.horizontalAlignmentMode = .Center
        self.subtitle.alpha = 0
        self.subtitle.runAction(SKAction.fadeInWithDuration(1.0))
    }
    
    func fadeInText(text: String, xPos: CGFloat, yPos: CGFloat) {
        let t = HUDText(text: text, xPos: xPos, yPos: yPos)
        self.addChild(t)
        t.horizontalAlignmentMode = .Center
        t.alpha = 0
        t.runAction(SKAction.fadeInWithDuration(1.0))
        self.text.append(t)
    }
    
    func clearContent() {
        //clear buttons
        for (var i = 0; i < self.buttons.count; i++) {
            self.buttons[i].removeFromParent()
        }
        self.buttons.removeAll()
        
        //clear text
        for (var i = 0; i < self.text.count; i++) {
            self.text[i].removeFromParent()
        }
        self.text.removeAll()
        self.subtitle?.removeFromParent()
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            //default options
            if (touchedNode.name == "backButton" && self.backButton.enabled) {
                //determine where to go based on state
                if (self.currentState == .DEFAULT) { //return to main menu
                    buttonClicked(self.backButton, scene: StartGameScene(size: self.size, title: "harvester"))
                }
                else { //return to default screen
                    buttonClicked(self.backButton, completion: { self.showOptions() })
                }
            }
            else if (touchedNode.name == "controlsButton" && self.controlsButton.enabled) {
                buttonClicked(self.controlsButton, completion: { self.showControlOptions() })
            }
            else if (touchedNode.name == "soundButton" && self.soundButton.enabled) {
                buttonClicked(self.soundButton, completion: { self.showSoundOptions() })
            }
            
            //control options
            else if (touchedNode.name == "motionControlsButton" && self.motionControlsButton.enabled) {
                gameData.controlScheme = "motion"
                highlightControlOptions()
            }
            else if (touchedNode.name == "virtualControlsButton" && self.virtualControlsButton.enabled) {
                gameData.controlScheme = "virtual"
                highlightControlOptions()
            }
            
            //sound options
            else if (touchedNode.name == "soundOnButton" && self.soundOnButton.enabled) {
                gameData.soundEnabled = true
                highlightSoundOptions()
            }
            else if (touchedNode.name == "soundOffButton" && self.soundOffButton.enabled) {
                gameData.soundEnabled = false
                highlightSoundOptions()
            }
        }
    }
    
}