//
//  File.swift
//  
//
//  Created by Justin Wilkin on 23/10/2022.
//

import SwiftUI

extension View {
    /// Forward `@Publshed` state changes to a local `@State` binding.
    ///
    /// - Parameters:
    ///   - publisher: The binding publisher @Published or @Binding from a store
    ///   - subject: Local @State subject to forward changes to
    public func forward<Value: Equatable>(_ publisher: Binding<Value>, to subject: Binding<Value>) -> some View {
        self.onChange(of: publisher.wrappedValue) { change in
            subject.wrappedValue = change
        }
    }
}
