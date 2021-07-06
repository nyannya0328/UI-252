//
//  MediaFile.swift
//  UI-252
//
//  Created by nyannyan0328 on 2021/07/05.
//

import SwiftUI

struct MediaFile: Identifiable {
    var id = UUID().uuidString
    var url : String
    var title : String

}

var MediaFileJSON = [
    
    //Don't need [mp4] because after in

MediaFile(url: "Cheetah - 53486", title: "Super Moving"),
MediaFile(url: "Coffee - 45358", title: "Can I get some coffee?"),
MediaFile(url: "Moon - 42422", title: "All the moon in the sky"),
MediaFile(url: "New Year - 60404", title: "It will be 20 second,MidNight"),
MediaFile(url: "Owl - 56136", title: "Owl Hover craft"),
MediaFile(url: "Sunset - 43292", title: "Im afraid of hights"),
MediaFile(url: "Storm - 40581", title: "Sunder Strom")




]

