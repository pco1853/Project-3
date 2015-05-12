//
//  TitleText.swift
//  SpaceInvaders
//
//  Created by Student on 5/11/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class TitleText: SKLabelNode {
    
    let titleFontName = "Inversionz"
    let titleFontSize: CGFloat = 90.0
    let titleFontColor = SKColor.whiteColor()
    let titleGlowColor = SKColor.redColor()
    
    init(text: String, xPos: CGFloat, yPos: CGFloat) {
        super.init()
        
        //set vars
        self.text = text
        self.position.x = xPos
        self.position.y = yPos
        
        //set consts
        self.fontName = titleFontName
        self.fontSize = titleFontSize
        self.fontColor = titleFontColor
        self.horizontalAlignmentMode = .Center
        self.verticalAlignmentMode = .Top
        
        //create glow effect
        let glow = SKLabelNode()
        glow.text = text
        glow.fontName = titleFontName
        glow.fontSize = titleFontSize
        glow.fontColor = titleGlowColor
        glow.horizontalAlignmentMode = .Center
        glow.verticalAlignmentMode = .Top
        glow.alpha = 1.0;
        
        let glowEffect = SKEffectNode()
        let glowEffectBlur = CIFilter(name: "CIGaussianBlur", withInputParameters: ["inputRadius": 5.0])
        glowEffect.filter = glowEffectBlur
        glowEffect.zPosition = -1
        glowEffect.addChild(glow)
        addChild(glowEffect)
        
        let glowSequence = SKAction.sequence([SKAction.fadeAlphaTo(0.95, duration: 1.0), SKAction.fadeAlphaTo(1.0, duration: 1.0)])
        let glowForever = SKAction.repeatActionForever(glowSequence)
        glowEffect.runAction(glowForever)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
