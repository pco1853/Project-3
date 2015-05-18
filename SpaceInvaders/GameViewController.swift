//
//  GameViewController.swift
//  SpaceInvaders
//
//  Created by Student on 4/21/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit
import Social

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //viewcontroller for sharing on facebook
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "shareScore", name: "share", object: nil)
        
        let startGameScene = StartGameScene(size: CGSizeMake(768, 1024), title: "harvester")
        startGameScene.scaleMode = .AspectFit //base size on iPad, scale down to iPhone
        
        let skView = view as SKView
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        skView.presentScene(startGameScene)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func shareScore()
    {
        let facebook = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        facebook.completionHandler = {
            result in
            switch result{
            case SLComposeViewControllerResult.Cancelled:
                break
                
            case SLComposeViewControllerResult.Done:
                break
            }
        
        }
        
        facebook.setInitialText("I scored \(gameData.score) points in Harvester")
        //facebook.addImage(gameData.scoreImage!)
        self.presentViewController(facebook, animated: false, completion: nil)
    }
    
}
