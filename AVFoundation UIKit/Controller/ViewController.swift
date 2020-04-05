//
//  ViewController.swift
//  AVFoundation UIKit
//
//  Created by Zohra Achour on 05/04/2020.
//  Copyright © 2020 Zohra Achour. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMIDI

class ViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    
    // MARK: - SETTUP USABLE VARIABLES
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var recordingSession: AVAudioSession!
    var fileName: String = ""
    
    
    // MARK: - OUTLETS
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        playButton.layer.cornerRadius = 20
        recordButton.layer.cornerRadius = 20
        
        setupRecorder()
    }

    
    // MARK: - RECORDER FUNCTION
    func setupRecorder() {
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = path[0]
        
        let audioFileName = documentsDirectory.appendingPathComponent("audioFile.m4a")
        
        let settings = [AVFormatIDKey: Int(kAudioFormatAppleLossless),
                        AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                        AVEncoderBitRateKey : 32000,
                        AVNumberOfChannelsKey : 2,
                        AVSampleRateKey : 44100.0
        ] as [String : Any]
        
        var error: NSError?
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileName, settings: settings)
        } catch {
            audioRecorder = nil
        }
        
        if let err = error {
            print("AVAudioRecorder error: \(err.localizedDescription)")
        } else {
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
        }
    }
    
    // MARK: - PREPARE TO PLAY
    func preparePlayer() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: getFileURL())
            audioPlayer.delegate = self
            audioPlayer.volume = 1.0
        } catch {
            if let err = error as Error? {
                print("AVAudioPlayer error: \(err.localizedDescription)")
                audioPlayer = nil
            }
        }
    }
    
    // MARK: - GET FILE URL
    func getFileURL() -> URL {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as URL
        let soundURL = documentDirectory.appendingPathComponent(fileName)
        return soundURL
    }
    
    
    @IBAction func recordAudio(_ sender: UIButton) {
        if sender.imageView?.image == UIImage(named: "mic.fill") {
            audioRecorder.record()
            sender.setImage(UIImage(named: "mic.slash.fill"), for: .normal)
        } else {
            audioRecorder.stop()
            sender.setImage(UIImage(named: "mic.fill"), for: .normal)
        }
    }
    
    @IBAction func playAudio(_ sender: UIButton) {
        if sender.imageView?.image == UIImage(named: "play.fill") {
            recordButton.isEnabled = false
            sender.setImage(UIImage(named: "stop.fill"), for: .normal)
                   preparePlayer()
            audioPlayer.play()
                   
               } else {
                   audioPlayer.stop()
                   sender.setImage(UIImage(named: "play.fill"), for: .normal)
               }
    }
    

}

