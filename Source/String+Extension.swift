//
//  String+Extension.swift
//  MYExtensions
//
//  Created by xmy on 2024/4/20.
//

import Foundation

public extension String {
    
    /// 格式化手机号（133 1111 1111）
    var formattedPhoneNumber: String {
        // 移除输入字符串中的空格
        let trimmedInput = self.replacingOccurrences(of: " ", with: "")
        // 存储结果的数组
        var formattedResult = [String]()
        // 前三位单独处理
        if trimmedInput.count >= 3 {
            let firstThree = trimmedInput.prefix(3)
            formattedResult.append(String(firstThree))
        }
        // 从第四位开始，每四位加一个空格
        var index = trimmedInput.index(trimmedInput.startIndex, offsetBy: 3)
        while index < trimmedInput.endIndex {
            let remainingLength = trimmedInput.distance(from: index, to: trimmedInput.endIndex)
            let chunkLength = min(4, remainingLength)
            let chunk = trimmedInput[index..<trimmedInput.index(index, offsetBy: chunkLength)]
            formattedResult.append(String(chunk))
            index = trimmedInput.index(index, offsetBy: chunkLength)
        }
        
        // 返回最终格式化后的字符串
        return formattedResult.joined(separator: " ")
    }
    
}
