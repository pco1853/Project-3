//
//  AudioManager.swift
//  SpaceInvaders
//
//  Created by Jason  on 5/16/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit
import AVFoundation


class AudioManager {
    
    var player = AVAudioPlayer() //use for background music, use SKActions for effects
    var isPlaying = false
    
    func playBackgroundMusic(fileName: String, loops: Int) {
        if (gameData.soundEnabled) {
            let source = NSBundle.mainBundle().URLForResource(fileName, withExtension: nil)
            var error: NSError?
        
            self.player = AVAudioPlayer(contentsOfURL: source, error: &error)

            if (source == nil) {
                println("Could not find file: \(fileName).")
                return
            }
        
            self.player.numberOfLoops = loops
            self.player.prepareToPlay()
            self.player.volume = 0.5
            self.player.play()
            
            self.isPlaying = true
        }
    }
    
    func playSoundEffect(fileName: String, node: SKNode) {
        if (gameData.soundEnabled) {
            node.runAction(SKAction.playSoundFileNamed(fileName, waitForCompletion: false))
        }
    }
    
    func stopAudio() {
        if (self.isPlaying) {
            self.player.stop()
            self.isPlaying = false
        }
    }
    
}

let audioManager = AudioManager()
    