//
//  ErasedObservableObject.swift
//  kinetic
//
//  Created by Justin Wilkin on 5/10/2022.
//

import Combine
import SwiftUI

/// Erased Observable Wrapper
///
/// Observable object with erased underyling type.
///
/// This wrapper object forwards change events from `AnyObservableObject`
/// to SwiftUI ObservableObject's internal `objectWillChange` property.
public class EmptyObservableObject: ObservableObject {
    private var cancellable: AnyCancellable?
    
    public init(changePublisher: AnyPublisher<Void, Never>) {
        cancellable = changePublisher
            .sink { [weak self] in
                // Forward our object change event to the ObservableObject
                self?.objectWillChange.send()
            }
    }
    
    public init() {}
}
