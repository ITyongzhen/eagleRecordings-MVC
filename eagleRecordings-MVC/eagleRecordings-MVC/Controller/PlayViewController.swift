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
    
    func updateForChangedRecording() {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
fileprivate extension String {
    static let uuidPathKey = "uuidPath"
    
    static let pause = NSLocalizedString("Pause", comment: "")
    static let resume = NSLocalizedString("Resume playing", comment: "")
    static let play = NSLocalizedString("Play", comment: "")
}
