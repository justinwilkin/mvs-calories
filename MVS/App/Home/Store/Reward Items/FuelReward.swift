//
//  Reward.swift
//  kinetic
//
//  Created by Justin Wilkin on 9/10/2022.
//

import Foundation

struct FuelReward: Identifiable {
    var id = UUID()
    var imageUrl: String = ""
    var headline: String
    var description: String
    var rewardDescription: String
}
