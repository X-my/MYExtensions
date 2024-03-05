//
//  Functions.swift
//  MYBaseUI
//
//  Created by 许梦阳 on 2023/3/25.
//

import Foundation

public func configure<T: AnyObject>(_ object: T, closure: (T) -> Void) -> T {
    closure(object)
    return object
}

/// async after in main queue
public func delay(_ delay: TimeInterval, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
}
