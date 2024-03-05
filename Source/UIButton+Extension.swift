//
//  UIButton+Extension.swift
//  MYExtensions
//
//  Created by xmy on 2023/4/17.
//

import UIKit
import SwifterSwift

public extension UIButton {
    
    func setBackgroundImage(with color: UIColor, for state: UIControl.State) {
        let image = UIImage(color: color, size: CGSize(width: 1, height: 1))
        setBackgroundImage(image, for: state)
    }
    
}
