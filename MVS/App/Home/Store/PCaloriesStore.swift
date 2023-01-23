//
//  PDashboardStore.swift
//  kinetic
//
//  Created by Justin Wilkin on 5/10/2022.
//

protocol PCaloriesStore: StoreObject {
    // MARK: Data state
    
    // MARK: View state
    
    // MARK: - Store functions
}

// MARK: - Dependency registration

extension DependencyMap {
    
    private struct CaloriesStoreKey: DependencyKey {
        static var dependency: any PCaloriesStore = CaloriesStore()
    }
    
    var caloriesStore: any PCaloriesStore {
        get { resolve(key: CaloriesStoreKey.self) }
        set { register(key: CaloriesStoreKey.self, dependency: newValue) }
    }
}
