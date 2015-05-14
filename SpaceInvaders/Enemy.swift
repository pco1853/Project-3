//
//  Enemy.swift
//  Harvester
//
//  Created by Student on 5/5/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import SpriteKit

class Enemy: SKSpriteNode {
    
    //MARK: - Variables -
    var hasPowerup: Bool = false
    //var powerup: Powerup! //TODO: implement powerups
    var movementSpeed: CGFloat?
    var bulletSpeed: CGFloat?
    var bulletDamage: CGFloat = 10.0
    var bullets: [Bullet] = []
    
    init(movementSpeed: CGFloat, bulletSpeed: CGFloat, bulletDamage: CGFloat, texture: SKTexture) {
        self.movementSpeed = movementSpeed
        self.bulletSpeed = bulletSpeed
        
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
    }
    
    func fireBullet(scene: SKScene){
        let bullet = Bullet(imageName: "laser")
        bullet.position.x = self.position.x
        bullet.position.y = self.position.y - self.size.height/2
        scene.addChild(bullet)
        let moveBulletAction = SKAction.moveTo(CGPoint(x:self.position.x,y: 0 - bullet.size.height), duration: 2.0)
        let removeBulletAction = SKAction.removeFromParent()
        bullet.runAction(SKAction.sequence([moveBulletAction,removeBulletAction]))
    }
    
    func outOfBounds(size: Size){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    

}
