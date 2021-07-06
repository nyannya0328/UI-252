//
//  CustomVideoPlayer.swift
//  UI-252
//
//  Created by nyannyan0328 on 2021/07/05.
//

import SwiftUI
import AVKit

struct CustomVideoPlayer: UIViewControllerRepresentable {
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    var player : AVPlayer
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        
        let view = AVPlayerViewController()
        view.player = player
        view.showsPlaybackControls = false
        view.videoGravity = .resizeAspectFill
        
        player.actionAtItemEnd = .none
        
        
        NotificationCenter.default.addObserver(context.coordinator, selector: #selector(context.coordinator.restartPlayBack), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
        
        return view
        
        
    }
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
    
    class Coordinator : NSObject{
        
        var parent : CustomVideoPlayer
        
        init(parent : CustomVideoPlayer){
            
            
            self.parent = parent
        }
        
        @objc func restartPlayBack(){
            
            
            
            parent.player.seek(to: .zero)
        }
        
    
        
        
        
        
    }
}


