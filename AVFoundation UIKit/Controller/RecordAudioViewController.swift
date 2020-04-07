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
    
    var numberOfRecords = 0
    
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Button design
        recordButton.setImage(UIImage(systemName: "mic.fill"), for: .normal)
        recordButton.tintColor = .systemOrange
        
        // Setting up session
        recordingSession = AVAudioSession.sharedInstance()
        
        AVAudioSession.sharedInstance().requestRecordPermission { ( hasPermission ) in
            if hasPermission {
                print("Accepted")
            }
        }
    }
    
    //MARK: - Get path directory
    func getDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = path[0]
        return documentDirectory
    }
    
    // MARK: - Display alert
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - RecordAudio
    @IBAction func recordAudio(_ sender: Any) {
        if audioRecorder == nil {
            numberOfRecords += 1
            let fileName = getDirectory().appendingPathComponent("\(numberOfRecords).m4a")
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            // Start recording
            do {
                audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
                audioRecorder.delegate = self
                audioRecorder.record()
                
                recordButton.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            } catch {
                displayAlert(title: "Woops!", message: "Recording failed")
            }
        } else {
            // Stop recording
            audioRecorder.stop()
            audioRecorder = nil
            recordButton.setImage(UIImage(systemName: "mic.fill"), for: .normal)
        }
        
    }
    

} // end of VC
