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
    
    /// 除首位字符外，其余字符全用"*"替换
    var maskedExceptFirstAndLast: String {
        guard count > 2, let first = first, let last = last else { return self }
        return String(first) + String(repeating: "*", count: self.count - 2) + String(last)
    }
    
    /// 邮箱"@"前面部分
    var maskedEmail: String {
        guard let atIndex = firstIndex(of: "@") else { return self }
        let username = String(prefix(upTo: atIndex))
        let domain = String(suffix(from: index(after: atIndex)))
        return "\(username.maskedExceptFirstAndLast)@\(domain)"
    }
    
    /// 生成二维码
    func generateQRCode(size: CGSize) -> UIImage? {
        let data = self.data(using: String.Encoding.ascii)
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        filter.setValue(data, forKey: "inputMessage")
        guard let qrcodeImage = filter.outputImage else { return nil }
        let scaleX = size.width / qrcodeImage.extent.size.width
        let scaleY = size.height / qrcodeImage.extent.size.height
        let transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        let transformedImage = qrcodeImage.transformed(by: transform)
        return UIImage(ciImage: transformedImage)
    }
}
