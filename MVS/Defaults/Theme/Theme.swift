//
//  Theme.swift
//  SwiftUI-MVS
//
//  Created by Justin Wilkin on 23/1/2023.
//

import SwiftUI

/// Niiave implementation of a theme
///
/// Trivial application of color extensions providing theme inside the application
/// A non trivial example would be done through injectin an environment object with a theme inside of it
/// that the app can subscribe to changes of

extension Color {
    static let background = ColorTokens.Neutrals.lightGrey
    static let onBackground = ColorTokens.Blacks.black
    
    static let surface = ColorTokens.Neutrals.white
    static let onSurface = ColorTokens.Blacks.black
}
