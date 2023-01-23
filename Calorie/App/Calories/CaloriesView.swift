//
//  CaloriesView.swift
//  kinetic
//
//  Created by Justin Wilkin on 27/9/2022.
//

import SwiftUI

struct CaloriesView: View {
    @Inject(\.caloriesInteractor) var interactor: any PCaloriesInteractor
    @Store(\.caloriesStore) var store: any PCaloriesStore
    
    // MARK: View composition
    var body: some View {
        VStack {
            caloriesContent
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color.background)
        .registerInteractorLifecycle(interactor)
    }
}

// MARK: - Callories content
extension CaloriesView {
    var caloriesContent: some View {
        VStack {
            HStack {
                Text("Previous meals")
                    .font(.headline)
                    .bold()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .foregroundColor(.onBackground)
            
            ScrollView(showsIndicators: false) {
                caloriesList
            }
        }
    }
}

// MARK: - Meals content
extension CaloriesView {
    var caloriesList: some View {
        store.meals.buildViewFromState { meals in
            buildMealsSection(with: meals)
        } loadingBlock: { _ in
            buildPlaceholderMeals()
        } errorBlock: { error in
            Text("\(error.localizedDescription)")
        }
    }
    
    private func buildMealsSection(with meals: [Meal]) -> some View {
        VStack {
            ForEach(meals, id: \.id) { meal in
                MealCell(meal: meal.meal, description: meal.description, calories: meal.calories)
            }
            
            addEntryButton
                .padding(.top)
        }
    }
    
    var addEntryButton: some View {
        RoundedButton(title: "Add meal", action: interactor.openAddMeal())
    }
}

// MARK: - Placeholder
extension CaloriesView {
    private func buildPlaceholderMeals() -> some View {
        VStack {
            PlaceholderMeal()
            PlaceholderMeal()
            PlaceholderMeal()
        }
    }
}

// MARK: - Previews
struct CaloriesView_Previews: PreviewProvider, DependencyMocker {
    class MockCaloriesInteractor: Interactor, PCaloriesInteractor {
        func closeAddMeal(meal: Meal?) {
            // do nothing
        }
        
        func openAddMeal() {
            // do nothing
        }
    }
    
    class MockCaloriesStore: StoreObject, PCaloriesStore {
        var addMealLoading: Bool = false
        var meals: StoreState<[Meal]> =
            .loaded(
                data: [Meal](repeating: Meal(meal: "Breakfast", description: "Steak and chips", calories: 1000), count: 5)
            )
    }
    
    static var previews: some View {
        mockInViewScope(\.caloriesInteractor, mock: MockCaloriesInteractor())
        mockInViewScope(\.caloriesStore, mock: MockCaloriesStore())
        CaloriesView()
    }
}
