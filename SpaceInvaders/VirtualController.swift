//
//  VirtualController.swift
//  SpaceInvaders
//
//  Created by Student on 5/12/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class VirtualController: SKSpriteNode
{
    
    //sets up the virtual controller UI overlay
    init(size:CGSize)
    {
        super.init(texture: nil, color: UIColor.clearColor(), size: size)
        
        //Left and right arrows are set
        var leftTexture = SKTexture(imageNamed: "LeftArrow.png")
        var leftArrow = SKSpriteNode(texture: leftTexture)
        leftArrow.size = leftTexture.size()
        leftArrow.color = UIColor.clearColor()
        leftArrow.name = "LeftArrow"
        leftArrow.position.x = size.width - (size.width * 0.90)
        leftArrow.position.y = size.height - (size.height * 0.85)
        self.addChild(leftArrow)
        
        var rightTexture = SKTexture(imageNamed: "RightArrow.png")
        var rightArrow = SKSpriteNode(texture: rightTexture)
        rightArrow.size = leftTexture.size()
        rightArrow.color = UIColor.clearColor()
        rightArrow.name = "RightArrow"
        rightArrow.position.x = size.width - (size.width * 0.10)
        rightArrow.position.y = size.height - (size.height * 0.85)
        self.addChild(rightArrow)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}