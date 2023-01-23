//
//  RewardsRepository.swift
//  kinetic
//
//  Created by Justin Wilkin on 14/11/2022.
//

import Combine
import Foundation

struct CaloriesRepository: PCaloriesRepository {
    private let subscriptionKey = "c6ead20a03d9983402b83debbfc68a333758a"
    private let mealsUrl = "https://calories-932e.restdb.io/rest/meals"
    private var headers: [String: String] {
        ["x-apikey": subscriptionKey]
    }
    
    func getMeals() -> AnyPublisher<[Meal], Error> {
        perform(.get, url: mealsUrl, headers: headers)
    }
    
    func addMeal(meal: Meal) -> AnyPublisher<AddMealResponse, Error> {
        perform(.post(body: meal.asBody()), url: mealsUrl, headers: headers)
    }
}
