//
//  Recorder.swift
//  AVFoundation UIKit
//
//  Created by Zohra Achour on 05/04/2020.
//  Copyright © 2020 Zohra Achour. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMIDI

func setupRecorder() {
    
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectory = path[0]
    
    let audioFileName = documentsDirectory.appendingPathComponent("audioFile.m4a")
    
    let settings = [AVFormatIDKey: Int(kAudioFormatAppleLossless),
                    AVEncoderAudioQualityKey : AVAudioQuality.max.rawValue,
                    AVEncoderBitRateKey : 32000,
                    AVNumberOfChannelsKey : 2,
                    AVSampleRateKey : 44100.0
    ]   as [String : Any]
    
    var error: NSError?
    
    do {
//        audioRecorder
    }
    
}
