//
//  DependencyMocker.swift
//  
//
//  Created by Justin Wilkin on 16/10/2022.
//

import SwiftUI

// MARK: - Dependency mocking
public protocol DependencyMocker {
    func mock<Dependency>(_ keyPath: WritableKeyPath<DependencyMap, Dependency>, mock: Dependency)
    func mockInViewScope<Dependency>(
        _ keyPath: WritableKeyPath<DependencyMap, Dependency>,
        mock: Dependency
    ) -> EmptyView
}

extension DependencyMocker {
    // MARK: Mock without returns
    public static func mock<Dependency>(_ keyPath: WritableKeyPath<DependencyMap, Dependency>, mock: Dependency) {
        DependencyMap.map[keyPath: keyPath] = mock
    }
    public func mock<Dependency>(_ keyPath: WritableKeyPath<DependencyMap, Dependency>, mock: Dependency) {
        Self.mock(keyPath, mock: mock)
    }
    
    // MARK: Mock inside ViewBuilder and View bodies
    public static func mockInViewScope<Dependency>(
        _ keyPath: WritableKeyPath<DependencyMap, Dependency>,
        mock: Dependency
    ) -> EmptyView {
        DependencyMap.map[keyPath: keyPath] = mock
        
        // Return an empty view for use inside a view scope
        return EmptyView()
    }
    public func mockInViewScope<Dependency>(
        _ keyPath: WritableKeyPath<DependencyMap, Dependency>,
        mock: Dependency
    ) -> EmptyView {
        Self.mockInViewScope(keyPath, mock: mock)
    }
}
