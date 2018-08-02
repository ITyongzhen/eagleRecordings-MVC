//
//  RecordViewController.swift
//  eagleRecordings-MVC
//
//  Created by yongzhen on 2018/7/30.
//  Copyright © 2018年 yongzhen. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class RecordViewController: UIViewController,AVAudioRecorderDelegate {
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var recording = Recording(name: "", uuid: UUID())
    var audioRecorder: Recorder?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        timeLabel.text = timeString(0)
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBAction func stopBtn(_ sender: UIButton) {
        
        
    }
    

    
    
    
}
