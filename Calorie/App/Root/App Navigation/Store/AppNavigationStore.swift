//
//  AppNavigationStore.swift
//  kinetic (iOS)
//
//  Created by Justin Wilkin on 19/7/2022.
//

import SwiftUI

final class AppNavigationStore: StoreObject, PAppNavigationStore {
    
    // MARK: - Injection
    
    // MARK: - Routing
    @Inject(\.routerStore) var router: RouterStore
    
    // MARK: - Instance properties
    @Published var tabs: [NavItem] = [
        NavItem(
            identifier: Constants.Tabs.rewards,
            icon: Constants.Icons.menu,
            destination: CaloriesView()
        )
    ]
    
    // MARK: - Lifecycle
    override func setup() {
        super.setup()
        router.tabSelectedSubject = tabs.first!.tabSelectSubject
    }
}
