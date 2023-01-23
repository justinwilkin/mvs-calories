//
//  InjectPublished.swift
//  kinetic
//
//  Created by Justin Wilkin on 5/10/2022.
//

import SwiftUI
import Combine

@propertyWrapper
public class InjectPublished<Dependency>: DynamicProperty, DependencyLifecycleScope {
    private var disposables = Set<AnyCancellable>()
    
    private let keyPath: WritableKeyPath<DependencyMap, Dependency>
    public var wrappedValue: Dependency {
        get { resolve(keyPath) }
        set {
            register(keyPath, dependency: newValue)
            observe()
        }
    }
    
    /// Publisher value
    ///
    /// The publisher value provides a change publisher similar to @Published and will notify the observer
    /// of any state changes to the `ObservableObject`
    private var _publisher = PassthroughSubject<Dependency, Never>()
    
    /// Projected value
    ///
    /// The projected value provides a `$` publisher accessor to the calling site, much like `Published`
    /// inside an `ObservableObject` and produces a publish event to observe changes in an interactor/store.
    public var projectedValue: AnyPublisher<Dependency, Never> {
        _publisher.eraseToAnyPublisher()
    }
    
    public init(_ keyPath: WritableKeyPath<DependencyMap, Dependency>) {
        self.keyPath = keyPath
        observe()
    }
    
    private func observe() {
        let observable = wrappedValue as? AnyObservableObject
        
        precondition(observable != nil, "Cannot observe an object that does not confrom to 'AnyObservableObject'")
        
        // Clear our subscriptions before resubscribing to a new dependency instance
        disposables.cancel()
        
        // Map our object will change to our publisher
        observable!.objectWillChange
            // Receive our willChange on the mainloop so we receive the newly updated wrappedValue
            // RunLoop.main ensures that we wait for SwiftUI's diff on the ObservableObject
            // to complete and receive the new value. (SwiftUI blocks execution on the main RunLoop whilst
            // processing the render tree for changed values)
            .receive(on: RunLoop.main)
            .map {
                // Retrieve the updated value after didSet and publish upstream
                self.wrappedValue
            }
            .subscribe(_publisher)
            .store(in: &disposables)
    }
}
