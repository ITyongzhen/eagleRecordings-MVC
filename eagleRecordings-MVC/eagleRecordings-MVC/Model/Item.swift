//
//  Item.swift
//  eagleRecordings-MVC
//
//  Created by yongzhen on 2018/8/2.
//  Copyright © 2018年 yongzhen. All rights reserved.
//

import Foundation
class Item {
    let uuid: UUID
    private(set) var name: String
    
    init(name: String, uuid: UUID) {
        self.name = name
        self.uuid = uuid
        
    }
    
}
extension Item {
    static let changeReasonKey = "reason"
    static let newValueKey = "newValue"
    static let oldValueKey = "oldValue"
    static let parentFolderKey = "parentFolder"
    static let renamed = "renamed"
    static let added = "added"
    static let removed = "removed"
}
