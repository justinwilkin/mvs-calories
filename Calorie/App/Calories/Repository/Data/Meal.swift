//
//  Meal.swift
//  SwiftUI-MVS
//
//  Created by Justin Wilkin on 23/1/2023.
//

import Foundation

struct Meal: Codable {
    let id: String?
    let meal: String
    let description: String
    let calories: Int
    
    init(id: String? = nil, meal: String, description: String, calories: Int) {
        self.id = id
        self.meal = meal
        self.description = description
        self.calories = calories
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(String.self, forKey: .id) ?? UUID().uuidString
        self.meal = try container.decode(String.self, forKey: .meal)
        self.description = try container.decode(String.self, forKey: .description)
        self.calories = try container.decode(Int.self, forKey: .calories)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case meal
        case description
        case calories
    }
}
