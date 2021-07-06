//
//  Reel.swift
//  UI-252
//
//  Created by nyannyan0328 on 2021/07/05.
//

import SwiftUI
import AVKit

struct Reel: Identifiable {
    var id = UUID().uuidString
    var player : AVPlayer?
    var mediaFile : MediaFile
}

