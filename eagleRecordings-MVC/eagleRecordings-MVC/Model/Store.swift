//
//  Store.swift
//  eagleRecordings-MVC
//
//  Created by yongzhen on 2018/8/2.
//  Copyright © 2018年 yongzhen. All rights reserved.
//

import Foundation

final class Store {
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
    
    
}
fileprivate extension String{
    static let storeLocation = "store.json"
}
