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
    weak var store: Store?
    weak var parent: Folder?{
        didSet{
            store = parent?.store
        }
    }
    
    init(name: String, uuid: UUID) {
        self.name = name
        self.uuid = uuid
        self.store = nil
    }
    
    func setName(_ newName: String)  {
        print("setName = %@",newName)
        name = newName
        if let p = parent {
            let (oldIndex, newIndex) = p.reSort(chageItem: self)
            store?.save(self, userInfo: [Item.changeReasonKey: Item.renamed, Item.oldValueKey: oldIndex, Item.newValueKey: newIndex,Item.parentFolderKey: p])
            
        }
        
        
    }
    func deleted() {
        print("deleted ")
        parent = nil
    }
    func item(atUUIDPath path: ArraySlice<UUID>) -> Item? {
        guard let first = path.first, first == uuid else{return nil}
        return self
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
