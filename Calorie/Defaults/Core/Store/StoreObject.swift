//
//  StoreObject.swift
//  kinetic
//
//  Created by Justin Wilkin on 19/7/2022.
//

import Combine

open class StoreObject: PStore {
    
    // MARK: - Instance variables
    var tasks = Set<AnyTask>()
    var disposables = Set<AnyCancellable>()
    
    // MARK: - Lifecycle
    public init() {
        setup()
    }
    
    /// Setup our Store at instantation
    ///
    /// Should do the initial Store set up when first created (created before the view's existence
    /// for injection)
    open func setup() {
        setupBindings()
        
        Task { await setup() }
    }
    
    /// Store setup with async execution
    ///
    /// Used for any async code during initial setup of store initial Store after the
    /// synchronous setup call
    open func setup() async {}
    
    /// Setup one time bindings
    ///
    /// For doing initial binding of data within this Store. Will be called on initialisation
    /// and will exist for the lifecycle of the Store.
    open func setupBindings() {}
    
    /// Cancel async tasks
    ///
    /// Cancel any API calls or bindings that are still in flight
    ///
    /// This should be called from  viewDissapear inside a SwiftUI content block
    /// and will setup our Store for use
    open func cancel() {
        disposables.cancel()
    }
}
