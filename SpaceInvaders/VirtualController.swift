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
    
    var joystick: Joystick!
    var fireButton: MenuButton!
    var harvestButton: MenuButton!
    var powerupButton: MenuButton!
    
    init(size: CGSize) {
        super.init(texture: nil, color: UIColor.clearColor(), size: CGSize(width: size.width, height: size.height * 0.25))
        self.position.x = size.width / 2
        self.position.y = (size.height / 2) - (size.height * 0.25) - (self.size.height / 2)
        
        //joystick setup
        self.joystick = Joystick()
        self.joystick.position = CGPointMake(-self.size.width / 2 + 110, 60)
        self.addChild(self.joystick)
        
        //buttons
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
        self.powerupButton.xScale = 0.5
        self.powerupButton.yScale = 0.5
        self.addChild(self.powerupButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}