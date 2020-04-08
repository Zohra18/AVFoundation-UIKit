//
//  DisplayAlert.swift
//  AVFoundation UIKit
//
//  Created by Zohra Achour on 08/04/2020.
//  Copyright © 2020 Zohra Achour. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

// MARK: - Display alert
func displayAlert(title: String, message: String) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "dismiss", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
}
