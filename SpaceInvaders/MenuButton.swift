//
//  MenuButton.swift
//  SpaceInvaders
//
//  Created by Student on 5/11/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class MenuButton: SKSpriteNode {
    
    var fill: SKSpriteNode!
    var label: SKLabelNode!
    var icon: SKSpriteNode!
    
    init(icon: String, label: String, name: String, xPos: CGFloat, yPos: CGFloat, enabled: Bool) {
        let outline = SKTexture(imageNamed: "MenuButtonOutline")
        super.init(texture: outline, color: SKColor.clearColor(), size: outline.size())
        
        self.name = name
        self.position.x = xPos
        self.position.y = yPos
        //self.userInteractionEnabled = enabled
        self.color = SKColor.redColor()
        self.colorBlendFactor = 1.0
        
        //set up fill
        self.fill = SKSpriteNode(imageNamed: "MenuButtonFill")
        self.fill.zPosition = -3
        self.fill.alpha = 0.9
        self.addChild(self.fill)
        
        //set up label
        self.label = SKLabelNode(text: label)
        self.label.zPosition = -2
        self.label.position.y -= 50
        self.label.fontName = "Inversionz"
        self.label.fontSize = 30.0
        self.label.fontColor = SKColor.blackColor()
        self.label.horizontalAlignmentMode = .Center
        self.label.verticalAlignmentMode = .Top
        addChild(self.label)
        
        //set up icon
        self.icon = SKSpriteNode(imageNamed: icon)
        self.icon.zPosition = -1
        self.icon.color = SKColor.blackColor()
        self.icon.colorBlendFactor = 1.0;
        addChild(self.icon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func animate() {
        self.runAction(SKAction.scaleBy(1.25, duration: 0.25))
        self.fill.runAction(SKAction.colorizeWithColor(SKColor.redColor(), colorBlendFactor: 1.0, duration: 0.25))
        self.label.fontColor = SKColor.whiteColor()
    }
    
}
