//
//  HUDText.swift
//  SpaceInvaders
//
//  Created by Student on 5/11/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class HUDText: SKLabelNode {
    
    let hudFontName = "SquareFont"
    let hudFontSize: CGFloat = 24.0
    let hudFontColor = SKColor.whiteColor()
    
    init(text: String, xPos: CGFloat, yPos: CGFloat) {
        super.init()
        
        //set vars
        self.text = text
        self.position.x = xPos
        self.position.y = yPos
        
        //set text properties
        self.fontName = hudFontName
        self.fontSize = hudFontSize
        self.fontColor = hudFontColor
        self.horizontalAlignmentMode = .Left
        self.verticalAlignmentMode = .Top
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
