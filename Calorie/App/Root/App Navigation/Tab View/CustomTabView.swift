//
//  CustomTabView.swift
//  kinetic
//
//  Created by Justin Wilkin on 18/7/2022.
//

import SwiftUI

// MARK: - Custom Tab View
public struct CustomTabView<Content: View>: View {
    @Store(\.routerStore) var router: RouterStore
    
    // MARK: Instance Properties
    var selection: Binding<TabSelectSubject?>
    let content: Content
    
    // MARK: Tab View Lifecycle
    
    /// Custom Tab View
    ///
    /// Custom Tab View used for navigation in the application. This gives custom functionality using SwiftUI
    /// as the TabView implementation is tightly coupled to UIKit and UITabBar.appearance()
    ///
    /// - Parameters:
    ///
    init(_ selection: Binding<TabSelectSubject?>, @ViewBuilder content: () -> Content) {
        self.selection = selection
        self.content = content()
    }
    
    public var body: some View {
        ///
        /// Body wrapper for TabView
        ///
        /// This wrapper is used to wrap both the current page view's contents
        /// as well as the fixed tab view.
        ///
        ZStack {
            // Background for the tab bar content
            Color.white
                .ignoresSafeArea()
            
            // Wrap our Custom Tab View and push to the bottom
            VStack(spacing: 0) {
                // Wrapper VStack to enforce content full width and height
                // even when wrappedValue is empty or EmptyView()
                VStack {
                    // Current selected page content
                    selection.wrappedValue?.destination.compose()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if router.isTabBarVisible {
                    tabBarWrapper
                        .transition(.move(edge: .bottom))
                }
            }
            .animation(.easeInOut, value: router.isTabBarVisible)
        }
    }
}

// MARK: - Configure content
extension CustomTabView {
    /// Arrange our TabItems horizontally within our custom tab bar
    var tabBarWrapper: some View {
        ZStack {
            // Tab bar background color to extend into safe area
            Color.white
                .ignoresSafeArea()
            
            HStack {
                content
            }
            .padding()
        }
        .frame(
            maxWidth: .infinity,
            maxHeight: 53
        )
    }
}

// MARK: - Previews
struct CustomTabView_Previews: PreviewProvider {
    @State static var selection: TabSelectSubject?
    static var tabs = [
        CustomTabItemView(
            id: Constants.Tabs.rewards,
            icon: Constants.Icons.menu,
            isSelected: false
        ),
    ]
    
    static var previews: some View {
        CustomTabView($selection) {
            ForEach(tabs, id: \.id) { tabItem in
                tabItem
            }
        }
    }
}
