//
//  PAppNavigationStore.swift
//  kinetic
//
//  Created by Justin Wilkin on 4/10/2022.
//

protocol PAppNavigationStore: StoreObject {
    var tabs: [NavItem] { get }
}

// MARK: - Dependency registration

extension DependencyMap {
    
    private struct AppNavigationStoreKey: DependencyKey {
        static var dependency: any PAppNavigationStore = AppNavigationStore()
    }
    
    var appNavigationStore: any PAppNavigationStore {
        get { resolve(key: AppNavigationStoreKey.self) }
        set { register(key: AppNavigationStoreKey.self, dependency: newValue) }
    }
}
