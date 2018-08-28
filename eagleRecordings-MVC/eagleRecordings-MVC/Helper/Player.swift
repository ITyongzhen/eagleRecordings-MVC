//
//  Player.swift
//  eagleRecordings-MVC
//
//  Created by yongzhen on 2018/8/17.
//  Copyright © 2018年 yongzhen. All rights reserved.
//

import Foundation
import AVFoundation
class Player: NSObject, AVAudioPlayerDelegate {
    
    private var audioPlayer: AVAudioPlayer
    private var timer: Timer?
    private var update: (TimeInterval?) -> ()
    
    init?(url: URL, update: @escaping(TimeInterval?) -> ()) {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch  {
            return nil
        }
        if let player = try? AVAudioPlayer(contentsOf: url) {
            audioPlayer = player
            self.update = update
        }else{
            return nil
        }
        super.init()
        
    }
    
    
    var duration: TimeInterval {
        return audioPlayer.duration
    }
    
    var isPlaying: Bool {
        return audioPlayer.isPlaying
    }
    
    var isPaused: Bool {
        return !audioPlayer.isPlaying && audioPlayer.currentTime > 0
    }
}
