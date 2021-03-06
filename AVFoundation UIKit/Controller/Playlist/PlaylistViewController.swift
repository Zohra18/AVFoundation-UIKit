//
//  PlaylistViewController.swift
//  AVFoundation UIKit
//
//  Created by Zohra Achour on 08/04/2020.
//  Copyright © 2020 Zohra Achour. All rights reserved.
//

import UIKit
import AVFoundation

class PlaylistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var audioPlayer: AVAudioPlayer!
    var numbersOfAudioTracks: Int = 0
    
    @IBOutlet weak var playlistTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
        playlistTableView.reloadData()
        playlistTableView.backgroundColor = UIColor(named: "darkTintColor")
        
        view.backgroundColor = UIColor(named: "bgColor")

    }
   
    // MARK: - Display alert
       func displayAlert(title: String, message: String) {
           let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
           alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
           present(alert, animated: true, completion: nil)
       }

    
    // MARK: - TableView Settings
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbersOfAudioTracks
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "audioTrackCell", for: indexPath) as? PlaylistTableViewCell {
            
            // cell settings
            cell.backgroundColor = UIColor(named: "bgColor")
            cell.audioTrackLabel.text = "AudioTrack # \(indexPath.row + 1)"
            
            // creating a custom backgroundColor for a selected cell
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor(named: "tintColor")
            cell.selectedBackgroundView = backgroundView
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    // MARK: - Play audio on selection
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let path = getDirectory().appendingPathComponent("\(indexPath.row + 1).m4a")
        
        do {
                audioPlayer = try AVAudioPlayer(contentsOf: path)
                audioPlayer.play()
        } catch {
            displayAlert(title: "Woops!", message: "Could not play AudioTrack # \(indexPath.row + 1)")
        }
    }
    
    
}
