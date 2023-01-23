//
//  RewardsRepository.swift
//  kinetic
//
//  Created by Justin Wilkin on 14/11/2022.
//

import Combine
import Foundation

struct CaloriesRepository: PCaloriesRepository {
    func getMeals() -> AnyPublisher<[Meal], Error> {
        perform(.get, url: "http://localhost:8080/meals")
    }
    
    func addMeal(meal: Meal) -> AnyPublisher<String, Error> {
        perform(.post(body: meal.asBody()), url: "http://localhost:8080/meal")
    }
}
