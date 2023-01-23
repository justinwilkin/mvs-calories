//
//  Router.swift
//  kinetic
//
//  Created by Justin Wilkin on 19/7/2022.
//

import SwiftUI

class RouterStore: StoreObject {
    
    // Backstack navigation type, for tracking previous navigation
    private enum NavType {
        case root
        case tab
    }
    
    // MARK: - Backstack
    private var backstack: [(navType: NavType, view: RouteableView?, tab: TabSelectSubject?)] = []
    
    /// Pop Root Stack
    ///
    /// Pops the root backstack, retrieving the last view in the navigation
    /// and routing it to the root view subject.
    func pop() {
        if let last = backstack.popLast() {
            switch last.navType {
            case .root: rootViewSubject = last.view
            case .tab: tabSelectedSubject = last.tab
            }
        }
    }
    
    // MARK: - Root navigation
    @Published private(set) var rootViewSubject: RouteableView?
    
    /// Navigate
    ///
    /// Navigates the rootViewSubject to the provided view,
    /// wrapping it in a `RouteableView` for composition to the SwiftUI view heirarchy.
    ///
    /// Maintains the backstack for recall and navigation back to the previous location
    ///
    /// - parameter view: the view to navigate the root view subject to
    func navigate(to view: some View) {
        // Add our last routeable view to the backstack for recall
        if let rootViewSubject {
            backstack.append((navType: NavType.root, view: rootViewSubject, tab: nil))
        }
        // Wrap our new view for composition and navigate
        rootViewSubject = RouteableView(view)
    }
    
    // MARK: - Tab navigation
    /// Selected Tab Subject
    ///
    /// The current selected tab subject, this should be set to the identifier of the tabSubject.
    /// This is bound in the AppNavigationView.
    ///
    /// - NOTE: AppNavigationView binds these tabSubjects to their respective views.
    @Published var tabSelectedSubject: TabSelectSubject? {
        didSet {
            // Add our tab change to the navigation backstack
            if let tab = oldValue {
                backstack.append((navType: NavType.tab, view: nil, tab: tab))
            }
        }
    }
    
    @Published var isTabBarVisible: Bool = true
    
    // MARK: - Full sheet presentation
    private(set) var fullSheetOverlaySubject: RouteableView? {
        didSet {
            // This will trigger objectWillChange on the shouldShow @Published
            shouldShowFullSheetOverlay = fullSheetOverlaySubject != nil
        }
    }
    @Published var shouldShowFullSheetOverlay: Bool = false
    
    /// Opens a fullscreen cover with the provided view
    ///
    /// Sets the fullSheetOverlaySubject to the provided view,
    /// wrapping it in a `RouteableView` for composition to the SwiftUI view heirarchy.
    ///
    /// - parameter view: the view to open in a full screen sheet to
    func openFullSheet(with view: some View, identifier: UUID = UUID()) {
        // Wrap our new view for composition and open
        fullSheetOverlaySubject = RouteableView(identifier: identifier, view)
    }
    
    /// Closes the fullscreen cover
    ///
    /// Sets the fullSheetOverlaySubject to not active,
    func closeFullSheet() {
        self.fullSheetOverlaySubject = nil
    }
    
    // MARK: - Modal sheet presentation
    private(set) var modalSheetOverlaySubject: RouteableView? {
        didSet {
            // This will trigger objectWillChange on the shouldShow @Published
            shouldShowModalSheetOverlay = modalSheetOverlaySubject != nil
        }
    }
    @Published var shouldShowModalSheetOverlay: Bool = false
    
    /// Opens a modal sheet cover with the provided view
    ///
    /// Sets the modalSheetOverlaySubject to the provided view,
    /// wrapping it in a `RouteableView` for composition to the SwiftUI view heirarchy.
    ///
    /// - parameter view: the view to open in a full screen sheet to
    func openModalSheet(with view: some View, identifier: UUID) {
        // Wrap our new view for composition and open
        modalSheetOverlaySubject = RouteableView(identifier: identifier, view)
    }
    
    /// Closes the modal sheet cover
    ///
    /// Sets the modalSheetOverlaySubject to not active,
    func closeModalSheet() {
        self.modalSheetOverlaySubject = nil
    }
}

// MARK: - Dependency registration
extension DependencyMap {
    
    private struct RouterStoreKey: DependencyKey {
        static var dependency: RouterStore = RouterStore()
    }
    
    var routerStore: RouterStore {
        get { resolve(key: RouterStoreKey.self) }
        set { register(key: RouterStoreKey.self, dependency: newValue) }
    }
}
