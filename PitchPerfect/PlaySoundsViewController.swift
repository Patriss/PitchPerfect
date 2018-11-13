//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by kzaracho on 5/7/18.
//  Copyright © 2018 kzaracho. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioURL:URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }

    //these code content the switch stament
    //what converts the button's tag to a
    //butonType.
    //then using the buttonType
    //we can play a sound appropriately.
    //slow, and fast button,
    //when they are pressed, we'll play the sound at a
    //diferent rate.
    @IBAction func playSoundForButton(_ sender: UIButton) {
      
            switch(ButtonType(rawValue: sender.tag)!) {
                case .slow:
                playSound(rate: 0.5)
                case .fast:
                playSound(rate: 1.5)
                case .chipmunk:
                playSound(pitch: 1000)
                case .vader:
                playSound(pitch: -1000)
                case .echo:
                playSound(echo: true)
                case .reverb:
                playSound(reverb: true)
                }
                configureUI(.playing)
    }
    //we add a cal to the stopaudio function in the class extension
    //and it will do the work to call AVAudioEngine to stop the playback
    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        // print("stop audio button pressed")
        stopAudio()
    }
    
    //setupAudio function
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    //configure the IU so the stop boton is disabled when view first appears
    //as the app won't be playing any sound until the user presses one of
    //the six playback button.
    //
    override func viewWillAppear(_ animated: Bool) {
        //we add our call to configureUI and we'll
        //pass it the notplaying state. Also while
        //
        configureUI(.notPlaying)
        
    }

 

}
