//
//  AppRootInteractor.swift
//  kinetic
//
//  Created by Justin Wilkin on 12/10/2022.
//

import Combine
import Foundation

final class AppRootInteractor: Interactor, PAppRootInteractor {
    
    // MARK: - Injection
    
    // MARK: - Routing
    @Inject(\.routerStore) var router: RouterStore
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func update() {
        super.update()
        
        // Navigate to our root navigation view on launch
        router.navigate(to: AppNavigationView())
    }
}
