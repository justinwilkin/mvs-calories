//
//  CaloriesView.swift
//  kinetic
//
//  Created by Justin Wilkin on 27/9/2022.
//

import SwiftUI

// MARK: - Rewards page
struct CaloriesView: View {
    @Inject(\.caloriesInteractor) var interactor: any PCaloriesInteractor
    @Store(\.caloriesStore) var store: any PCaloriesStore
    
    // MARK: View composition
    var body: some View {
        ZStack(alignment: .top) {
            CaloriesContent
        }
        .registerInteractorLifecycle(interactor)
    }
}

// MARK: - Rewards content
extension CaloriesView {
    var CaloriesContent: some View {
        Text("My deals")
            .font(.title)
            .bold()
            .padding()
    }
}

// MARK: - Previews
struct CaloriesView_Previews: PreviewProvider, DependencyMocker {
    class MockCaloriesInteractor: Interactor, PCaloriesInteractor {
    }
    
    class MockCaloriesStore: StoreObject, PCaloriesStore {
    }
    
    static var previews: some View {
        mockInViewScope(\.caloriesInteractor, mock: MockCaloriesInteractor())
        mockInViewScope(\.caloriesStore, mock: MockCaloriesStore())
        CaloriesView()
    }
}
