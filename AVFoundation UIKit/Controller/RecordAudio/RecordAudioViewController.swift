//
//  RecordAudioViewController.swift
//  AVFoundation UIKit
//
//  Created by Zohra Achour on 07/04/2020.
//  Copyright © 2020 Zohra Achour. All rights reserved.
//

import UIKit
import AVFoundation

class RecordAudioViewController: UIViewController, AVAudioRecorderDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    var numberOfRecords: Int = 0
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - ViewDiDLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Button design
        recordButton.setImage(UIImage(systemName: "mic.fill"), for: .normal)
        recordButton.tintColor = .systemOrange
        
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
        
        // TV settup
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
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
            tableView.reloadData()
            
            recordButton.setImage(UIImage(systemName: "mic.fill"), for: .normal)
        }
        
    }
    

    // MARK: - TableView Settup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRecords
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "audioCell", for: indexPath) as? AudioTableViewCell {
            cell.textLabel?.text = "AudioTrack # \(String(indexPath.row + 1))"
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    // Play audio for each cell selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let path = getDirectory().appendingPathComponent("\(indexPath.row + 1).m4a")
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: path)
            audioPlayer.play()
        } catch {
            displayAlert(title: "Woops!", message: "Couldn't play audio")
        }
    }
} // end of VC

