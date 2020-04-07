//
//  RecordAudioViewController.swift
//  AVFoundation UIKit
//
//  Created by Zohra Achour on 07/04/2020.
//  Copyright © 2020 Zohra Achour. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController, AVAudioRecorderDelegate {
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setting up session
        recordingSession = AVAudioSession.sharedInstance()
        
        AVAudioSession.sharedInstance().requestRecordPermission { ( hasPermission ) in
            if hasPermission {
                print("Accepted")
            }
        }
    }
    

    @IBAction func recordAudio(_ sender: Any) {
    }
    

}
