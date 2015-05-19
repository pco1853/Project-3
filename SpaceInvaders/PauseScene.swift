import UIKit
import SpriteKit

class PauseScene: MenuScene {
    
    var gameScene: GameScene!
    var resumeButton: MenuButton!
    var quitButton: MenuButton!
    
    init(size: CGSize, title: String, background: SKSpriteNode) {
        super.init(size: size, title: title)
        self.starField.alpha = 0
        
        let b = background
        b.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        b.xScale *= 1.1
        b.yScale *= 1.1
        self.addChild(b)
        
        //add buttons
        self.resumeButton = MenuButton(
            icon: "play",
            label: "RESUME",
            name: "resumeButton",
            xPos: size.width / 2 - 100.5,
            yPos: size.height / 2,
            enabled: true
        )
        self.buttons.append(self.resumeButton)
        self.addChild(self.resumeButton)
        
        self.quitButton = MenuButton(
            icon: "back",
            label: "QUIT",
            name: "quitButton",
            xPos: size.width / 2 + 100.5,
            yPos: size.height / 2,
            enabled: true
        )
        self.buttons.append(self.quitButton)
        self.addChild(self.quitButton)
        
        //set z index
        b.zPosition = DrawOrder.PauseMenuBackground
        self.titleText.zPosition = DrawOrder.PauseMenu
        for button in self.buttons {
            button.zPosition = DrawOrder.PauseMenu + 3
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            
            let touchLocation = touch.locationInNode(self)
            let touchedNode = self.nodeAtPoint(touchLocation)
            
            if (touchedNode.name == "resumeButton" && self.resumeButton.enabled) {
                self.gameScene = self.parent as GameScene
                self.gameScene.paused = false
                buttonClicked(self.resumeButton, completion: { self.gameScene.resume() })
            }
            else if (touchedNode.name == "quitButton" && self.quitButton.enabled) {
                self.gameScene = self.parent as GameScene
                self.gameScene.paused = false
                buttonClicked(self.quitButton, completion: { self.gameScene.quit() })
            }
        }
    }
    
}


