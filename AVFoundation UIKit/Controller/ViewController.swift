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
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playButton.tintColor = .systemOrange
        recordButton.layer.cornerRadius = 20
        recordButton.setImage(UIImage(systemName: "mic.fill"), for: .normal)
        recordButton.tintColor = .systemOrange
        
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
        if sender.imageView?.image == UIImage(systemName: "mic.fill") {
            audioRecorder.record()
            sender.setImage(UIImage(systemName: "circle.fill"), for: .normal)
            print("recording")
        } else {
            audioRecorder.stop()
            sender.setImage(UIImage(systemName: "mic.fill"), for: .normal)
            print("recording ended")
        }
    }
    
    @IBAction func playAudio(_ sender: UIButton) {
        if sender.imageView?.image == UIImage(systemName: "play.fill") {
            recordButton.isEnabled = false
            sender.setImage(UIImage(systemName: "stop.fill"), for: .normal)
            preparePlayer()
            audioPlayer.play()
            print("playing")
        } else {
            audioPlayer.stop()
            sender.setImage(UIImage(systemName: "play.fill"), for: .normal)
            print("playing ended")
        }
    }
    
    
}

