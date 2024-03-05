//
//  CGAffineTransform+Extension.swift
//  MYExtensions
//
//  Created by xmy on 2024/2/2.
//

import Foundation

extension CGAffineTransform {
    public init(from source: CGRect, to destination: CGRect) {
        self = CGAffineTransform.identity
            .translatedBy(x: destination.midX - source.midX, y: destination.midY - source.midY)
            .scaledBy(x: destination.width / source.width, y: destination.height / source.height)
    }
}
