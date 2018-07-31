//
//  Uitlities.swift
//  eagleRecordings-MVC
//
//  Created by yongzhen on 2018/7/31.
//  Copyright © 2018年 yongzhen. All rights reserved.
//

import Foundation
import UIKit

private let formatter: DateComponentsFormatter = {
   let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .positional
    formatter.zeroFormattingBehavior = .pad
    formatter.allowedUnits = [.hour, .minute, .second]
    
    return formatter
}()

func timeString(_ time: TimeInterval) -> String {
    return formatter.string(from: time)!
}

fileprivate extension String{
    
    static let ok = NSLocalizedString("OK", comment: "")
    static let cancel = NSLocalizedString("cancel", comment: "")
}
