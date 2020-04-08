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
    
    // Audio settings
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    var numberOfRecords: Int = 0
    
    // outlet
    @IBOutlet weak var recordButton: UIButton!
    
    // MARK: - ViewDiDLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Button design
        recordButton.setImage(UIImage(systemName: "mic.fill"), for: .normal)
        recordButton.tintColor = .systemOrange
        recordButton.layer.cornerRadius = 40
        view.backgroundColor = UIColor(named: "bgColor")
        
        // NavController settup
        navigationController?.navigationBar.barTintColor = UIColor(named: "bgColor")
        navigationController?.navigationBar.tintColor = .systemOrange
        
        // Setting up session
        recordingSession = AVAudioSession.sharedInstance()
        
        if let number: Int = UserDefaults.standard.object(forKey: "myNumber") as? Int {
            numberOfRecords = number
        }
        
        // Check for permission
        AVAudioSession.sharedInstance().requestRecordPermission { ( hasPermission ) in
            if hasPermission {
                print("Accepted")
            }
        }
    } // end of VDL
    
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
                AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
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
            
            UserDefaults.standard.set(numberOfRecords, forKey: "myNumber")
            
            recordButton.setImage(UIImage(systemName: "mic.fill"), for: .normal)
            
            // send audio to playlistVC
            performSegue(withIdentifier: "pushAudio", sender: nil)
        }
        
    }
    
    // MARK: - Prepare for segue
    // prepare data to be send to PlaylistVC
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let playlistVC = segue.destination as! PlaylistViewController
        playlistVC.numbersOfAudioTracks = numberOfRecords
    }
    
} // end of VC

