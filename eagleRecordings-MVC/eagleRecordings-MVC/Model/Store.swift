//
//  Store.swift
//  eagleRecordings-MVC
//
//  Created by yongzhen on 2018/8/2.
//  Copyright © 2018年 yongzhen. All rights reserved.
//

import Foundation

final class Store {
    static let changedNotification = Notification.Name("StoreChanged")
    static private let documentDirectory = try! FileManager.default.url(for: .libraryDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    static let shared = Store(url: documentDirectory)
    private(set) var rootFolder: Folder
    
    
    
    let baseUrl: URL?
    var placeUrl: URL?
    
    init(url: URL?) {
        self.baseUrl = url
        self.placeUrl = nil
        
        if let u = url,
            let data = try? Data(contentsOf: u.appendingPathComponent(.storeLocation)),
            let folder = try? JSONDecoder().decode(Folder.self, from: data)
        {
            self.rootFolder = folder
        }else{
            self.rootFolder = Folder(name: "", uuid: UUID())
        }
        self.rootFolder.store = self
    }
    
    func fileUrl(for recording: Recording) -> URL? {
        return (baseUrl?.appendingPathComponent(recording.uuid.uuidString + ".m4a") ?? placeUrl)

    }
    
    func save(_ notifying: Item, userInfo: [AnyHashable: Any]) {
        if let url = baseUrl, let data = try? JSONEncoder().encode(rootFolder) {
            try! data.write(to: url.appendingPathComponent(.storeLocation))
            
        }
        NotificationCenter.default.post(name: Store.changedNotification, object: notifying, userInfo: userInfo)
        
    }
    
}
fileprivate extension String{
    static let storeLocation = "store.json"
}
