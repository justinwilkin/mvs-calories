//
//  CalorieCell.swift
//  SwiftUI-MVS
//
//  Created by Justin Wilkin on 23/1/2023.
//

import SwiftUI

struct MealCell: View {
    // MARK: View properties
    var meal: String
    var description: String
    var calories: Int
    
    init(meal: String, description: String, calories: Int) {
        self.meal = meal
        self.description = description
        self.calories = calories
    }
    
    // MARK: View composition
    public var body: some View {
        RoundedShape {
            HStack(spacing: 10) {
                mealDetails
                calorieDescription
            }
            .foregroundColor(.onBackground)
        }
    }
}

// MARK: - Meal sections
extension MealCell {
    
    var mealDetails: some View {
        VStack(alignment: .leading, spacing: 4) {
            if !meal.isEmpty {
                Text(meal)
                    .font(.headline)
            }
            
            if !description.isEmpty {
                Text(description)
                    .font(.caption)
                    .opacity(0.6)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    var calorieDescription: some View {
        VStack(spacing: 4) {
            Text("\(calories)")
                .font(.subheadline)
                .bold()
            
            Text("Calories")
                .font(.caption2)
                .opacity(0.6)
        }
        .frame(width: 45)
    }
}

// MARK: - Previews
struct MealCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            MealCell(
                meal: "Breakfast",
                description: "",
                calories: 1200
            )
            
            MealCell(
                meal: "Dinner",
                description: "Steak and mash",
                calories: 1400
            )
        }
        .padding()
        .frame(maxHeight: .infinity)
        .background(Color.background)
    }
}
