//
//  Store.swift
//  eagleRecordings-MVC
//
//  Created by yongzhen on 2018/8/2.
//  Copyright © 2018年 yongzhen. All rights reserved.
//

import Foundation

final class Store {
    let baseUrl: URL?
    var placeUrl: URL?
    
    init(url: URL) {
        self.baseUrl = url
        self.placeUrl = nil
        
    }
    
    func fileUrl(for recording: Recording) -> URL? {
        return (baseUrl?.appendingPathComponent(recording.uuid.uuidString + ".m4a") ?? placeUrl)

    }
    
    
}
fileprivate extension String{
    static let storeLocation = "store.json"
}
