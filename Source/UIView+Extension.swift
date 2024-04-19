//
//  UIView+Extension.swift
//  MYExtensions
//
//  Created by 许梦阳 on 2023/3/19.
//

import UIKit

public extension UIView {
    
    var safeAreaInsetBottom: CGFloat {
        if #available(iOS 11.0, *) {
            return safeAreaInsets.bottom
        } else {
            return 0
        }
    }
    
    var safeAreaInsetTop: CGFloat {
        if #available(iOS 11.0, *) {
            return safeAreaInsets.top
        } else {
            return 0
        }
    }
    
    convenience init(backgroundColor: UIColor?) {
        self.init()
        self.backgroundColor = backgroundColor
    }
    
}
