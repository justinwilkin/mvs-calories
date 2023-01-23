//
//  AddMealView.swift
//  SwiftUI-MVS
//
//  Created by Justin Wilkin on 24/1/2023.
//

import SwiftUI

struct AddMealView: View {
    // MARK: Injection
    @Inject(\.caloriesInteractor) var interactor: any PCaloriesInteractor
    @Store(\.caloriesStore) var store: any PCaloriesStore
    
    // MARK: Local state
    @State private var meal: String = ""
    @State private var description: String = ""
    @State private var calories: String = ""
    private var numberCalories: Int {
        Int(calories) ?? 0
    }
    private var userMeal: Meal {
        Meal(meal: meal, description: description, calories: numberCalories)
    }
    
    // MARK: View composition
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            
            caloriesContent
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Rewards content
extension AddMealView {
    var caloriesContent: some View {
        VStack {
            // Live updating meal cell as the user enters details
            MealCell(meal: meal, description: description, calories: numberCalories)
                .padding(.bottom)
            
            // Input fields
            
            buildInputField(title: "Meal", text: $meal)
            buildInputField(title:"Description", text: $description)
            buildInputField(title:"Calories", text: $calories)
            
            // User actions
            actions
                .padding(.top)
        }
        .padding()
    }
    
    func buildInputField(title: String, text: Binding<String>) -> some View {
        RoundedShape(backgroundColor: .surface) { TextField(title, text: text) }
    }
    
    var actions: some View {
        VStack {
            // Save our user's meal
            RoundedButton(
                title: "Save",
                loading: store.addMealLoading,
                action: interactor.closeAddMeal(meal: userMeal)
            )
            
            // Cancel our users meal
            RoundedButton(
                title: "Cancel",
                action: interactor.closeAddMeal()
            )
        }
    }
}

// MARK: - Meals content
extension AddMealView {
    
}

// MARK: - Previews
struct AddMealView_Previews: PreviewProvider, DependencyMocker {
    
    static var previews: some View {
        AddMealView()
    }
}
