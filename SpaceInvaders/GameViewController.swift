//
//  GameViewController.swift
//  SpaceInvaders
//
//  Created by Student on 4/21/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startGameScene = StartGameScene(size: CGSizeMake(768, 1024), title: "harvester")
        startGameScene.scaleMode = .AspectFill //base size on iPad, scale down to iPhone
        
        let skView = view as SKView
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        skView.presentScene(startGameScene)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
