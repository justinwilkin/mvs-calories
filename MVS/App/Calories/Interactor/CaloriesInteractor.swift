//
//  CaloriesInteractor.swift
//  kinetic
//
//  Created by Justin Wilkin on 11/10/2022.
//

import Combine
import Foundation
import SwiftUI

final class CaloriesInteractor: Interactor, PCaloriesInteractor {
    
    // MARK: - Injection
    @Inject(\.caloriesStore) var store: any PCaloriesStore
    @Inject(\.caloriesRepository) var repository: any PCaloriesRepository
    
    // MARK: - Routing
    @Inject(\.routerStore) var router: RouterStore
    
    // MARK: - Lifecycle
    override func update() {
        super.update()
        fetchMeals()
    }
    
    // MARK: - View interaction
    func openAddMeal() {
        router.openModalSheet(with: AddMealView())
    }
    
    func closeAddMeal(meal: Meal? = nil) {
        if let meal {
            repository.addMeal(meal: meal)
                .receive(on: DispatchQueue.main)
                .mapEvents { _ in
                    self.completeSaveMeal()
                } loadingBlock: {
                    self.store.addMealLoading = true
                } errorBlock: { _ in
                    self.store.addMealLoading = false
                }
                .store(in: &disposables)
        }
    }
    
    private func completeSaveMeal() {
        store.addMealLoading = false
        router.closeModalSheet()
        
        // Fetch our meals again after adding a new one
        fetchMeals()
    }
    
    // MARK: - Local interactor methods
    private func fetchMeals() {
        repository.getMeals()
            .receive(on: DispatchQueue.main)
            .mapEvents { output in
                self.store.meals.loaded(with: output)
            } loadingBlock: {
                self.store.meals.loading()
            } errorBlock: { error in
                self.store.meals.error(with: error)
            }
            .store(in: &disposables)
    }
}
