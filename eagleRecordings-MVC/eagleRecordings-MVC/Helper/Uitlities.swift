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
extension UIViewController{
    func modalTextAlert(title: String, accept: String = .ok, cancel: String = .cancel, placeHolder: String, callBack: @escaping (String?) -> ()) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: cancel, style: .cancel) { _ in
            callBack(nil)
        })
        
        alert .addAction(UIAlertAction(title: accept, style: .default){ _ in
            callBack(alert.textFields?.first?.text)
        })
        present(alert, animated: true)
        
    }
}
fileprivate extension String{
    
    static let ok = NSLocalizedString("OK", comment: "")
    static let cancel = NSLocalizedString("cancel", comment: "")
}
