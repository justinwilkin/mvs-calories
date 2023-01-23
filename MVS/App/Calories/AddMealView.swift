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
    
    // MARK: View composition
    var body: some View {
        VStack {
            caloriesContent
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Rewards content
extension AddMealView {
    var caloriesContent: some View {
        VStack {
            RoundedButton(title: "Save", loading: store.addMealLoading, action: interactor.closeAddMeal(meal: Meal(id: "", meal: "", description: "", calories: 1000)))
            RoundedButton(title: "Cancel", action: interactor.closeAddMeal())
        }
        .padding()
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
