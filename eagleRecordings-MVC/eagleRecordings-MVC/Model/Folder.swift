//
//  Folder.swift
//  eagleRecordings-MVC
//
//  Created by yongzhen on 2018/8/2.
//  Copyright © 2018年 yongzhen. All rights reserved.
//

import Foundation
class Folder: Item, Codable {
    private(set) var contents: [Item]
    override weak var store: Store?{
        didSet{
            contents.forEach{$0.store = store}
        }
    }
    
    override init(name: String, uuid: UUID) {
        contents = []
        super.init(name: name, uuid: uuid)
    }
    
    enum FolderKeys: CodingKey {
        case name, uuid, contents
    }
    
    enum FolderOrRecording: CodingKey {
        case Folder, recording
    }
    
    required init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: FolderKeys.self)
        contents = [Item]()
        var nested = try c.nestedUnkeyedContainer(forKey: .contents)
        
        let wrapper = try nested.nestedContainer(keyedBy: FolderOrRecording.self)
        while true {
            
            if let f = try wrapper.decodeIfPresent(Folder.self, forKey: .Folder) {
                contents.append(f)
            } else if let r = try wrapper.decodeIfPresent(Recording.self, forKey: .recording) {
                contents.append(r)
            } else {
                break
            }
        }
        
        let uuid = try c.decode(UUID.self, forKey: .uuid)
        let name = try c.decode(String.self, forKey: .name)
        
        super.init(name: name, uuid: uuid)
        for c in contents {
            c.parent = self
        }
    }
    
    
    
    func encode(to encoder: Encoder) throws {
        var c = encoder.container(keyedBy: FolderKeys.self)
        try c.encode(name, forKey: .name)
        try c.encode(uuid, forKey: .uuid)
        var nested = c.nestedUnkeyedContainer(forKey: .contents)
        for c in contents {
            var wrapper = nested.nestedContainer(keyedBy: FolderOrRecording.self)
            switch c {
            case let f as Folder: try wrapper.encode(f, forKey: .Folder)
            case let r as Recording: try wrapper.encode(r, forKey: .recording)
            default: break
            }
        }
        _ = nested.nestedContainer(keyedBy: FolderOrRecording.self)
    }
    
    override func item(atUUIDPath path: ArraySlice<UUID>) -> Item? {
        guard path.count > 1 else {return super.item(atUUIDPath: path)}
        guard path.first == uuid else {
            return nil
        }
        
        let subsequest = path.dropFirst()
        guard let second = subsequest.first else {
            return nil
        }
        
        return contents.first { $0.uuid == second }.flatMap { $0.item(atUUIDPath: subsequest) }

    }
    
}