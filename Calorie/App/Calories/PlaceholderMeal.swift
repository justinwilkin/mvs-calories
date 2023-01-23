//
//  PlaceholderMeal.swift
//  SwiftUI-MVS
//
//  Created by Justin Wilkin on 23/1/2023.
//

import SwiftUI

// MARK: Placeholder Meal
struct PlaceholderMeal: View {
    // MARK: View properties
    
    public init() {}
    
    // MARK: View composition
    var body: some View {
        RoundedShape {
            HStack {
                details
                calories
            }
            .shimmering()
            .foregroundColor(.onSurface)
        }
    }
}

// MARK: - Reward sections
extension PlaceholderMeal {

    // Rewards title and description placeholder for offer
    var details: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.background)
                .frame(maxWidth: 200)
                .frame(height: 17)
            
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.background)
                .frame(height: 17)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var calories: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.background)
                .frame(width: 45)
                .frame(height: 17)
            
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.background)
                .frame(width: 45)
                .frame(height: 17)
        }
        .padding(.leading)
        .frame(alignment: .leading)
    }
}

// MARK: - Previews
struct PlaceholderMeal_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PlaceholderMeal()
            PlaceholderMeal()
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(Color.background)
    }
}
