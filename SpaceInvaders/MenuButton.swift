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
    var enabled : Bool = true
    
    init(icon: String, label: String, name: String, xPos: CGFloat, yPos: CGFloat, enabled: Bool) {
        let outline = SKTexture(imageNamed: "button_menuOutline")
        super.init(texture: outline, color: SKColor.clearColor(), size: outline.size())
        
        self.name = name
        self.position.x = xPos
        self.position.y = yPos
        self.enabled = enabled
        
        //set up fill
        self.fill = SKSpriteNode(imageNamed: "button_menuFill")
        self.fill.zPosition = -3
        self.fill.alpha = 0.1
        self.addChild(self.fill)
        
        //set up label
        self.label = SKLabelNode(text: label)
        self.label.zPosition = -2
        self.label.position.y -= 50
        self.label.fontName = "SquareFont"
        self.label.fontSize = 24.0
        self.label.fontColor = SKColor.whiteColor()
        self.label.horizontalAlignmentMode = .Center
        self.label.verticalAlignmentMode = .Top
        addChild(self.label)
        
        //set up icon
        self.icon = SKSpriteNode(imageNamed: icon)
        self.icon.zPosition = -1
        self.icon.color = SKColor.whiteColor()
        self.icon.colorBlendFactor = 1.0;
        addChild(self.icon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func highlight() {
        self.fill.alpha = 1.0
        self.label.fontColor = SKColor.redColor()
        self.icon.color = SKColor.redColor()
        self.icon.colorBlendFactor = 1.0
    }
    
    func undoHighlight()
    {
        self.fill.alpha = 0.1
        self.label.fontColor = SKColor.whiteColor()
        self.icon.color = SKColor.whiteColor()
    }
    
}
