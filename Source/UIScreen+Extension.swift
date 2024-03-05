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
    
    var width: CGFloat {
        return bounds.width
    }
    
    var height: CGFloat {
        return bounds.height
    }
    
}
