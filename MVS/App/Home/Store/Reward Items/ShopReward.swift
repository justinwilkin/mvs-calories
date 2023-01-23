//
//  ShopReward.swift
//  kinetic
//
//  Created by Justin Wilkin on 9/10/2022.
//

import Foundation

struct ShopReward: Identifiable {
    var id = UUID()
    var image: String
    var headline: String
    var description: String
    var longDescription: String
    var validUnitl: String
}
