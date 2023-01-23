//
//  Theme.swift
//  SwiftUI-MVS
//
//  Created by Justin Wilkin on 23/1/2023.
//

import SwiftUI

// MARK: - Color definitions
internal struct ColorTokens {
    // MARK: - Neutrals
    struct Neutrals {
        static let white = Color.white
        static let lightGrey = Color(0xf5f5f5)
    }
    
    // MARK: - Combustion blacks
    struct Blacks {
        static let black = Color(0x222222)
        static let black80 = Color(0x282828)
        static let black60 = Color(0x636363)
        static let black30 = Color(0x949494)
        static let black20 = Color(0xb8b8b8)
        static let black10 = Color(0xdbdbdb)
        static let blackOver = Color(0x424242)
    }
    
    // MARK: - Combustion reds
    struct Reds {
        static let red = Color(0xed0c06)
    }
    
    // MARK: - Combustion blues
    struct Blues {
        static let blue = Color(0x18249c)
    }
}

// MARK: - Hex Shorthand
extension Color {
    /// Create a color from a UInt hex
    /// e.g. 0xFFFFFF
    init(_ hex: UInt, alpha: Double = 1) {
        self.init(
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
