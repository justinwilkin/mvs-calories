//
//  AddMealResponse.swift
//  Calorie
//
//  Created by Justin Wilkin on 24/1/2023.
//

import Foundation

struct AddMealResponse: Codable {
    let id, meal, description: String
    let calories: Int
    let keywords: [String]
    let version: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case meal
        case description
        case calories
        case keywords = "_keywords"
        case version = "_version"
    }
}
