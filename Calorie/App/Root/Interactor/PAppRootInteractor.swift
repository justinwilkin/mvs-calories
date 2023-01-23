//
//  PAppRootInteractor.swift
//  kinetic
//
//  Created by Justin Wilkin on 12/10/2022.
//

protocol PAppRootInteractor: Interactor {}

// MARK: - Dependency registration

extension DependencyMap {
    
    private struct AppRootInteractorKey: DependencyKey {
        static var dependency: any PAppRootInteractor = AppRootInteractor()
    }
    
    var appRootInteractor: any PAppRootInteractor {
        get { resolve(key: AppRootInteractorKey.self) }
        set { register(key: AppRootInteractorKey.self, dependency: newValue) }
    }
}
