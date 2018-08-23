//
//  Recording.swift
//  eagleRecordings-MVC
//
//  Created by yongzhen on 2018/8/1.
//  Copyright © 2018年 yongzhen. All rights reserved.
//

import Foundation
class Recording: Item, Codable {
    override init(name: String, uuid: UUID){
        super.init(name: name, uuid: uuid)
    }
    
    enum RecordingKeys: CodingKey {
        case name, uuid
    }
    var fileURL: URL? {
        return store?.fileUrl(for: self)
    }
    required init(from decoder: Decoder) throws {
        let c = try decoder.container(keyedBy: RecordingKeys.self)
        let name  = try c.decode(String.self, forKey: .name)
        let uuid = try c.decode(UUID.self, forKey: .uuid)
        super.init(name: name, uuid: uuid)
    }
    
    func encode(to encoder:Encoder) throws{
        var c =  encoder.container(keyedBy: RecordingKeys.self)
        try c.encode(name, forKey: .name)
        try c.encode(uuid, forKey: .uuid)
    }
}
