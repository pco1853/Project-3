//
//  VirtualController.swift
//  SpaceInvaders
//
//  Created by Student on 5/12/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class VirtualController: SKSpriteNode {
    
    var fireButton: MenuButton!
    var harvestButton: MenuButton!
    var powerupButton: MenuButton!
    
    var joystick: Joystick!
    //sets up the virtual controller UI overlay
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSize(width: size.width, height: size.height * 0.25))
        self.position.x = size.width / 2
        self.position.y = (size.height / 2) - (size.height * 0.25) - (self.size.height / 2)
        
        //Left and right arrows are set
        var leftTexture = SKTexture(imageNamed: "LeftArrow.png")
        var leftArrow = SKSpriteNode(texture: leftTexture)
        leftArrow.size = leftTexture.size()
        leftArrow.color = UIColor.clearColor()
        leftArrow.name = "LeftArrow"
        leftArrow.position.x = -self.size.width / 2 + 120
        leftArrow.position.y = 0
        self.addChild(leftArrow)
        
        var rightTexture = SKTexture(imageNamed: "RightArrow.png")
        var rightArrow = SKSpriteNode(texture: rightTexture)
        rightArrow.size = leftTexture.size()
        rightArrow.color = UIColor.clearColor()
        rightArrow.name = "RightArrow"
        rightArrow.position.x =  leftArrow.position.x + 120
        rightArrow.position.y = 0
        self.addChild(rightArrow)
        
        self.fireButton = MenuButton(icon: "", label: "FIRE", name: "fireButton", xPos: self.size.width / 2 - 120, yPos: 0, enabled: true)
        self.fireButton.zPosition = 1000
        self.fireButton.xScale = 0.5
        self.fireButton.yScale = 0.5
        self.addChild(self.fireButton)
        
        self.harvestButton = MenuButton(icon: "", label: "HARVEST", name: "harvestButton", xPos: self.fireButton.position.x - self.fireButton.size.width / 2 - 0.25, yPos: self.fireButton.position.y + self.fireButton.size.height / 1.33, enabled: true)
        self.harvestButton.zPosition = 1000
        self.harvestButton.xScale = 0.5
        self.harvestButton.yScale = 0.5
        self.addChild(self.harvestButton)
        
        self.powerupButton = MenuButton(icon: "", label: "POWERUP", name: "powerupButton", xPos: self.fireButton.position.x + self.fireButton.size.width / 2 + 0.25, yPos: self.fireButton.position.y + self.fireButton.size.height / 1.33, enabled: false)
        self.zPosition = 1000
        self.powerupButton.alpha = 0.5
        self.powerupButton.xScale = 0.5
        self.powerupButton.yScale = 0.5
        self.addChild(self.powerupButton)
        
        //joystick setup
        joystick = Joystick()
        joystick.position = CGPointMake(-self.size.width / 2 + 110, 20)
        addChild(joystick)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}