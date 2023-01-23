//
//  PCaloriesInteractor.swift
//  kinetic
//
//  Created by Justin Wilkin on 11/10/2022.
//

protocol PCaloriesInteractor: Interactor {

}

// MARK: - Dependency registration

extension DependencyMap {
    
    private struct CaloriesInteractorKey: DependencyKey {
        static var dependency: any PCaloriesInteractor = CaloriesInteractor()
    }
    
    var caloriesInteractor: any PCaloriesInteractor {
        get { resolve(key: CaloriesInteractorKey.self) }
        set { register(key: CaloriesInteractorKey.self, dependency: newValue) }
    }
}
