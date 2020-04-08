//
//  PlaylistTableViewCell.swift
//  AVFoundation UIKit
//
//  Created by Zohra Achour on 08/04/2020.
//  Copyright © 2020 Zohra Achour. All rights reserved.
//

import UIKit

class PlaylistTableViewCell: UITableViewCell {

    @IBOutlet weak var audioTrackImageView: UIImageView!
    @IBOutlet weak var audioTrackLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        audioTrackImageView.image = UIImage(systemName: "music.note")
        audioTrackImageView.tintColor = .systemOrange
        audioTrackLabel.textColor = .systemOrange
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
