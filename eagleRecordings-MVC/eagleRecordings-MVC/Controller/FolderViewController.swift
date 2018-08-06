//
//  FolderViewController.swift
//  eagleRecordings-MVC
//
//  Created by yongzhen on 2018/8/3.
//  Copyright © 2018年 yongzhen. All rights reserved.
//

import Foundation
import UIKit
class FolderViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftItemsSupplementBackButton = false
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    
    @IBAction func createNewFolder(_ sender: Any) {
        
    }
    
    @IBAction func createNewRecoder(_ sender: Any) {
        performSegue(withIdentifier: .showRecorder, sender: self)
    }
}
fileprivate extension String {
    static let uuidPathKey = "uuidPath"
    static let showRecorder = "showRecorder"
    static let showPlayer = "showPlayer"
    static let showFolder = "showFolder"
    
    static let recordings = NSLocalizedString("Recordings", comment: "Heading for the list of recorded audio items and folders.")
    static let createFolder = NSLocalizedString("Create Folder", comment: "Header for folder creation dialog")
    static let folderName = NSLocalizedString("Folder Name", comment: "Placeholder for text field where folder name should be entered.")
    static let create = NSLocalizedString("Create", comment: "Confirm button for folder creation dialog")
}
