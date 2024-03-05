//
//  UIWindow+Extension.swift
//  MYExtensions
//
//  Created by 许梦阳 on 2023/4/5.
//

import UIKit

public extension UIWindow {
    
    static var keyWindow: UIWindow? {
        let window: UIWindow?
        if #available(iOS 13.0, *) {
            window = UIApplication.shared.windows.first
        } else {
            window = UIApplication.shared.keyWindow
        }
        return window
    }
    
}
