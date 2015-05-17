//
//  AudioManager.swift
//  SpaceInvaders
//
//  Created by Jason  on 5/16/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation
import AVFoundation

class AudioManager {
    var backgroundSound: AVAudioPlayer!
    
    init(){
        
    }
    
    func playBackgroundSound(filename: String, loops: Int){
        let source = NSBundle.mainBundle().URLForResource(filename, withExtension: nil)
        var error: NSError?
        
        backgroundSound = AVAudioPlayer(contentsOfURL: source, error: &error)

        if source == nil {
            println("Could not find file: \(filename)")
            return
        }
        if backgroundSound == nil {
            println("Could not create audio player")
            return
        }
        
        backgroundSound.numberOfLoops = loops
        backgroundSound.prepareToPlay()
        backgroundSound.play()
    }
    
    func stopAudio(){
        backgroundSound.stop()
    }
}

let sharedAudio = AudioManager()
    
    