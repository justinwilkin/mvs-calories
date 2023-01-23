//
//  CaloriesStore.swift
//  kinetic
//
//  Created by Justin Wilkin on 27/9/2022.
//

import Combine
import Foundation

final class CaloriesStore: StoreObject, PCaloriesStore {
    
    // MARK: - Injection
    
    // MARK: - Instance properties
    @Published var meals: StoreState<[Meal]> = .loading()
    
    // MARK: - Meals view state
    @Published var addMealLoading: Bool = false
    
    // MARK: - Lifecycle
}
