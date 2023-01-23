//
//  Injector.swift
//  kinetic
//
//  Created by Justin Wilkin on 4/10/2022.
//

@propertyWrapper
public struct Inject<Dependency>: DependencyLifecycleScope {
    private let keyPath: WritableKeyPath<DependencyMap, Dependency>
    public var wrappedValue: Dependency {
        get { resolve(keyPath) }
        set { register(keyPath, dependency: newValue) }
    }
    public init(_ keyPath: WritableKeyPath<DependencyMap, Dependency>) {
        self.keyPath = keyPath
    }
}
