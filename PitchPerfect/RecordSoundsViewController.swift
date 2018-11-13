//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by kzaracho on 5/5/18.
//  Copyright © 2018 kzaracho. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate{
    
    var audioRecorder: AVAudioRecorder!

    @IBOutlet weak var recordingLabel: UILabel!
    
    @IBOutlet weak var recordButton: UIButton!
    
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //this disabled the stop recording button by default
        stopRecordingButton.isEnabled = false
    }
    
    //xcode show a suggestion
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear called")
    }

    @IBAction func recordAudio(_ sender: AnyObject) {
        
        recordingLabel.text = "Recording in Progress"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with:AVAudioSessionCategoryOptions.defaultToSpeaker)
        
        //we wanna set these viewcontroller as a delegator of the AVAudioRecorder
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
    
        recordButton.isEnabled  = true
        stopRecordingButton.isEnabled = false
        recordingLabel.text = "Tap to Record"
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
        
    }
    
    //these is the function we use to call the stopRecording Segue that we set up
    //earlier and move to the audio playback scene
    //right now when recording is complete,
    //the file saved and the AVAudioRecorder call the auidorecorderfinishrecording
    //because we set this view controller as its delegate.
    //we then need to call the stop recording segue and send along
    // with it the path to our recorded sound. We add this line to the
    //
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
       //here we can call the stop recording segue and send to it
        //the path where the recorded file is located. here the path
        
        
        //Is the successfully flag is true, then we'll perfom the segue,
        //otherwise we'll print out a message that the recording failed
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        
        } else {
            print("recording was not successful")
        }
        
    }
    
    
    /*
      before Storyboard executes the segue, it will call our RecordSoundsViewController to prepare for that segue. In preparing, the RecordSoundsViewController will store away the path to the recorded audio.     */
    //function prepare for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
        
    
    
}

