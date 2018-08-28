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
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleChangeNotification(_:)), name: Store.changedNotification, object: nil)
        
    }
    
    @objc func handleChangeNotification(_ notification: NSNotification) {
        if let item = notification.object as? Folder,item === folder {
            let reason = notification.userInfo?[Item.changeReasonKey] as? String
            if reason == Item.removed, let nc = navigationController{
                nc.setViewControllers(nc.viewControllers.filter{ $0 != self}, animated: false)
            }else{
                folder = item
            }
        }
        
        guard let userInfo = notification.userInfo, userInfo[Item.parentFolderKey] as? Folder === folder else { return  }
        
        if let chageReason = userInfo[Item.changeReasonKey] as? String {
            let oldValue = userInfo[Item.newValueKey]
            let newValue = userInfo[Item.oldValueKey]
            switch(chageReason, newValue, oldValue){
            case let (Item.removed, _, (oldValue as Int)?):
                tableView.deleteRows(at: [IndexPath(row: oldValue, section: 0)], with: .right)
                
            case let (Item.added, (newValue as Int)?, _):
                tableView.insertRows(at: [IndexPath(row: newValue, section: 0) ], with: .left)
                
            case let (Item.renamed, (newValue as Int)?, (oldValue as Int)?):
                tableView.moveRow(at: IndexPath(row: oldValue, section: 0), to: IndexPath(row: newValue, section: 0))
                tableView.reloadRows(at: [IndexPath(row: newValue, section: 0)], with: .fade)
                
            default:tableView.reloadData()
            }
            
        }else{
            tableView.reloadData()
        }
        
        
    }
    var selectedItem: Item? {
        if let indexPath = tableView.indexPathForSelectedRow {
            return folder.contents[indexPath.row]
        }
        return nil
    }
    
    @IBAction func createNewFolder(_ sender: Any) {
        
    }
    
//    @IBAction func createNewRecoder(_ sender: Any) {
//        performSegue(withIdentifier: .showRecorder, sender: self)
//    }
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
    
    // tableview
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return folder.contents.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = folder.contents[indexPath.row]
        let identifier = item is Recording ? "RecordingCell" : "FolderCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel!.text = "\((item is Recording) ? "🔊" : "📁")  \(item.name)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        folder.remove(folder.contents[indexPath.row])
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = PlayViewController()
        
        self.navigationController?.pushViewController(vc, animated: true)
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
