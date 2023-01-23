//
//  Codable+asBody.swift
//  SwiftUI-MVS
//
//  Created by Justin Wilkin on 24/1/2023.
//

import Foundation

extension Encodable {
    func asBody() -> Data? {
        let encoder = JSONEncoder()
        return try? encoder.encode(self)
    }
}
