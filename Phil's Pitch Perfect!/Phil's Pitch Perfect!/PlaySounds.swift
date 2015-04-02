//
//  PlaySounds.swift
//  Phil's Pitch Perfect!
//
//  Created by Phillip Hughes on 26/03/2015.
//  Copyright (c) 2015 Phillip Hughes. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySounds: UIViewController {
    
    //Declare global variables
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    //Declare UI buttons as variables
    @IBOutlet weak var playSlowAudio: UIButton!
    @IBOutlet weak var playFastAudio: UIButton!
    @IBOutlet weak var StopAudio: UIButton!
    
    //Defines what happens when the page first loads - including the passing in of the audio file
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
   }
    
    //Plays back the recorded audio at half the normal rate. Stops any currently playing audio first.
    @IBAction func playSlowAudio(sender: UIButton) {
            audioPlayer.stop()
            audioEngine.stop()
            audioPlayer.rate = 0.5
            audioPlayer.currentTime = 0.0
            audioPlayer.play()
    }
  
     //Plays back the recorded audio at double normal rate. Stops any currently playing audio first.
    @IBAction func playFastAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        audioPlayer.rate = 2.0
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    //Plays back recorded audio in a higher pitch, stops any audio playing first.
    @IBAction func playChipmunkAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        playAudioWithVariablePitch(1000)
    }
    
    //Plays back recorded audio in a lower pitch, stops any audio playing first.
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        audioPlayer.stop()
        audioEngine.stop()
        playAudioWithVariablePitch(-1000)

    }
    
    //Define the function that handles the pitch
    func playAudioWithVariablePitch(pitch: Float){
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        
        audioEngine.attachNode(changePitchEffect)
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
    }
    
    //Stops all currently playing audio
    @IBAction func StopAudio(sender: UIButton) {
           audioPlayer.stop()
            audioEngine.stop()
    }
    
}