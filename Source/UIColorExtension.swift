//
//  UIColorExtension.swift
//  MYExtensions
//
//  Created by xmy on 2024/4/10.
//

import UIKit

public extension UIColor {
    func alpha(_ alpha: CGFloat) -> UIColor {
        return self.withAlphaComponent(alpha)
    }
}
