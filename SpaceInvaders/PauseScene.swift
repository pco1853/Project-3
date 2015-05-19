import UIKit
import SpriteKit

class PauseScene: SKSpriteNode {
    
    var gameScene: GameScene!
    var titleText: TitleText!
    var resumeButton: MenuButton!
    var quitButton: MenuButton!
    var buttons: [MenuButton] = []
    
    init(size: CGSize, background: SKSpriteNode) {
        super.init(texture: background.texture, color: SKColor.clearColor(), size: size)
        self.userInteractionEnabled = true
        
        //add title
        self.titleText = TitleText(text: "pause", xPos: 0, yPos: self.size.height / 2 - 200)
        addChild(self.titleText)
        
        //add buttons        
        self.resumeButton = MenuButton(
            icon: "play",
            label: "RESUME",
            name: "resumeButton",
            xPos: -100.5,
            yPos: 0,
            enabled: true
        )
        self.buttons.append(self.resumeButton)
        self.addChild(self.resumeButton)
        
        self.quitButton = MenuButton(
            icon: "quit",
            label: "QUIT",
            name: "quitButton",
            xPos: 100.5,
            yPos: 0,
            enabled: true
        )
        self.buttons.append(self.quitButton)
        self.addChild(self.quitButton)
        
        //set z index
        self.zPosition = DrawOrder.PauseMenuBackground
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
    
    func buttonClicked(button: MenuButton, completion block: (() -> Void)!) {
        if (button.enabled) {
            button.enabled = false
            button.zPosition = 1000
            button.highlight()
            
            let fadeOut = SKAction.fadeOutWithDuration(0.25)
            for (var i = 0; i < buttons.count; i++) {
                if (buttons[i].name != button.name) {
                    self.buttons[i].enabled = false
                    buttons[i].runAction(fadeOut)
                }
            }
            
            button.fill.runAction(SKAction.fadeAlphaTo(1.0, duration: 0.25))
            button.runAction(SKAction.scaleBy(1.25, duration: 0.25), completion: {
                button.runAction(fadeOut, completion: {
                    block()
                })
            })
        }
    }

    
}


