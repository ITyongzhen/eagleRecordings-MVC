//
//  PlayViewController.swift
//  eagleRecordings-MVC
//
//  Created by yongzhen on 2018/8/15.
//  Copyright © 2018年 yongzhen. All rights reserved.
//
import UIKit
import Foundation
class PlayViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var playButton: UIButton!
    @IBOutlet var progressLabel: UILabel!
    @IBOutlet var durationLabel: UILabel!
    @IBOutlet var progressSlider: UISlider!
    @IBOutlet var noRecordingLabel: UILabel!
    @IBOutlet var activeItemElements: UIView!
    var audioPlayer: Player?
    var recording: Recording?{
        didSet{
            updateForChangedRecording()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = UIColor.red
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
        updateForChangedRecording()
        
    }
    
    func updateForChangedRecording() {
        if let r = recording, let url = r.fileURL {
            
            
        }else{
            
        }
        
        
        
    }
    func updateProgressDisplays(progress: TimeInterval, duration: TimeInterval) {
        progressLabel.text = timeString(progress)
        durationLabel.text = timeString(duration)
        progressSlider.maximumValue = Float(duration)
        progressSlider.value = Float(progress)
        updatePlayButton()
    }
    
    func updatePlayButton() {
        if audioPlayer?.isPlaying == true {
            playButton?.setTitle(.pause, for: .normal)
        } else if audioPlayer?.isPaused == true {
            playButton?.setTitle(.resume, for: .normal)
        } else {
            playButton?.setTitle(.play, for: .normal)
        }
        
    }
    
}
fileprivate extension String {
    static let uuidPathKey = "uuidPath"
    
    static let pause = NSLocalizedString("Pause", comment: "")
    static let resume = NSLocalizedString("Resume playing", comment: "")
    static let play = NSLocalizedString("Play", comment: "")
}
