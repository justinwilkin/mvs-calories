//
//  Headers.swift
//  SwiftUI-MVS
//
//  Created by Justin Wilkin on 22/1/2023.
//

import Foundation

public struct Headers {
    public static let accepts = ["Accept": "application/json"]
    public static let contentType = ["Content-Type": "application/json"]
    public static let charset = ["charset": "utf-8"]
    
    // Create our default by merging our values
    public static let `default`: [String: String] = [:]
        .merging(accepts, uniquingKeysWith: MergingStrategy.overwrite)
        .merging(contentType, uniquingKeysWith: MergingStrategy.overwrite)
        .merging(charset, uniquingKeysWith: MergingStrategy.overwrite)
}
