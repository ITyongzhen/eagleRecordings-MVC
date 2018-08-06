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
    var folder: Folder? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        timeLabel.text = timeString(0)
    }
    override func viewWillAppear(_ animated: Bool) {
        audioRecorder = folder?.store?.fileUrl(for: recording).flatMap{ url in
            Recorder(url: url){ time in
                if let t = time {
                    self.timeLabel.text = timeString(t)
                } else {
                    self.dismiss(animated: true)
                }
            }
        }
        
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @IBAction func stopBtn(_ sender: UIButton) {
        
        
    }
    

    
    
    
}
