//
//  AppNavigationView.swift
//  kinetic
//
//  Created by Justin Wilkin on 18/7/2022.
//

import SwiftUI

struct AppNavigationView: View {
    @Store(\.routerStore) var router: RouterStore
    @Store(\.appNavigationStore) var store: any PAppNavigationStore
    
    var body: some View {
        navigationTabView
    }
}

// MARK: - Tab View
extension AppNavigationView {
    
    var navigationTabView: some View {
        CustomTabView($router.tabSelectedSubject) {
            // Create our tabView's tabs from our list
            ForEach(store.tabs, id: \.tab.identifier) { navItem in
                // Currently selected tab should match our stored tabSelectSubject identifier
                let isSelected = $router.tabSelectedSubject.wrappedValue?.tab == navItem.tab.identifier
                // Create our custom tab item
                CustomTabItemView(
                    id: navItem.tab.identifier,
                    icon: navItem.tab.icon,
                    isSelected: isSelected
                )
                .onTapGesture {
                    router.tabSelectedSubject = navItem.tabSelectSubject
                }
            }
        }
    }
}

// MARK: - Previews
struct AppNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        AppNavigationView()
    }
}
