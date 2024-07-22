//
//  UIScreen+Extension.swift
//  MYExtensions
//
//  Created by 许梦阳 on 2023/3/28.
//

import UIKit

public let UIScreenScale = UIScreen.main.scale

public let UIScreenPixel = 1.0 / UIScreenScale

public extension UIScreen {
    
    static var width: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    static var height: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    static var safeAreaTop: CGFloat {
        UIWindow.keyWindow?.safeAreaInsetTop ?? 0
    }
    
    static var safeAreaBottom: CGFloat {
        UIWindow.keyWindow?.safeAreaInsetBottom ?? 0
    }
    
    static var safeScreenHeight: CGFloat {
        height - safeAreaTop - safeAreaBottom
    }
    
    static var topInsetWithNavigationBar: CGFloat {
        return safeAreaTop + 44
    }
    
}
