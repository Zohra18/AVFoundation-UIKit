//
//  GetDirectory.swift
//  AVFoundation UIKit
//
//  Created by Zohra Achour on 08/04/2020.
//  Copyright © 2020 Zohra Achour. All rights reserved.
//

import Foundation
import AVFoundation

//MARK: - Get path directory
func getDirectory() -> URL {
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentDirectory = path[0]
    return documentDirectory
}
