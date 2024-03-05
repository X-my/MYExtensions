//
//  Encodable+Extension.swift
//  MYExtensions
//
//  Created by xmy on 2023/5/11.
//

import Foundation

public extension Encodable {
    
    func jsonDictionary() throws -> [String: Any]? {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .init(rawValue: 0))
        return jsonObject as? [String: Any]
    }
    
}
