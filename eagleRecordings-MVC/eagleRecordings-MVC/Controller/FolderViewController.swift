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
    var folder: Folder = Store.shared.rootFolder{
        didSet {
            tableView.reloadData()
            if folder === folder.store?.rootFolder {
                title = .recordings
            } else {
                title = folder.name
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftItemsSupplementBackButton = false
        navigationItem.leftBarButtonItem = editButtonItem
    }
    var selectedItem: Item? {
        if let indexPath = tableView.indexPathForSelectedRow {
            return folder.contents[indexPath.row]
        }
        return nil
    }
    
    @IBAction func createNewFolder(_ sender: Any) {
        
    }
    
    @IBAction func createNewRecoder(_ sender: Any) {
        performSegue(withIdentifier: .showRecorder, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        if identifier == .showFolder {
            guard
                let folderVC = segue.destination as? FolderViewController,
                let selectedFolder = selectedItem as? Folder
                else { fatalError() }
            folderVC.folder = selectedFolder
        }
        else if identifier == .showRecorder {
            guard let recordVC = segue.destination as? RecordViewController else { fatalError() }
            recordVC.folder = folder
        } else if identifier == .showPlayer {
            guard
                let playVC = (segue.destination as? UINavigationController)?.topViewController as? PlayViewController,
                let recording = selectedItem as? Recording
                else { fatalError() }
            playVC.recording = recording
            if let indexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
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
