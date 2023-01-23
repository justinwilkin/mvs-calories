//
//  RewardsRepository.swift
//  kinetic
//
//  Created by Justin Wilkin on 14/11/2022.
//

import Combine
import Foundation

struct CaloriesRepository: PCaloriesRepository {
    func getMeals() -> AnyPublisher<Calories, Error> {
        perform(.get, url: "https://randomuser.me/api/")
    }
}
