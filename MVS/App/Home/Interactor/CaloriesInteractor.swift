//
//  CaloriesInteractor.swift
//  kinetic
//
//  Created by Justin Wilkin on 11/10/2022.
//

import Combine
import Foundation

final class CaloriesInteractor: Interactor, PCaloriesInteractor {
    
    // MARK: - Injection
    @Inject(\.caloriesStore) var store: any PCaloriesStore
    
    // MARK: - Routing
    @Inject(\.routerStore) var router: RouterStore
    
    // MARK: - Lifecycle
    override func update() {
        super.update()
    }
    
    // MARK: - View interaction
    
    // MARK: - Local interactor methods

}
