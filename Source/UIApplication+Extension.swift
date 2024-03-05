//
//  UIApplication+Extension.swift
//  MYExtensions
//
//  Created by xmy on 2023/4/15.
//

import UIKit

public extension UIApplication {
    
    var rootViewController: UIViewController? {
        if #available(iOS 13.0, *) {
            let keyWindow = connectedScenes
                .filter({ $0.activationState == .foregroundActive })
                .map({ $0 as? UIWindowScene })
                .compactMap({ $0 })
                .first?.windows
                .first(where: { $0.isKeyWindow })
            return keyWindow?.rootViewController
        } else {
            return keyWindow?.rootViewController
        }
    }

}
