//
//  OffersRepository.swift
//  
//
//  Created by Justin Wilkin on 14/11/2022.
//

import Combine
import Foundation

protocol PCaloriesRepository: Repository {
    func getMeals() -> AnyPublisher<Calories, Error>
}

extension DependencyMap {
    
    private struct CaloriesRepositoryKey: DependencyKey {
        static var dependency: any PCaloriesRepository = CaloriesRepository()
    }
    
    var caloriesRepository: any PCaloriesRepository {
        get { resolve(key: CaloriesRepositoryKey.self) }
        set { register(key: CaloriesRepositoryKey.self, dependency: newValue) }
    }
}
