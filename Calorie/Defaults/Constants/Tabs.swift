//
//  Tabs.swift
//  kinetic
//
//  Created by Justin Wilkin on 26/9/2022.
//

extension Constants {
    enum Tabs {
        case rewards
        
        var name: String {
            switch self {
            case .rewards:
                return "Rewards"
            }
        }
    }
}
