//
//  FeatureStoreRegistrationTests.swift
//  KineticTests
//
//  Created by Justin Wilkin on 27/12/2022.
//

import XCTest
import KineticInjection
@testable import kinetic

final class FeatureStoreRegistrationTests: XCTestCase, DependencyMocker {
    // MARK: - Mock objects
    
    // MARK: - Test objects
    @Inject(\.appEnvironment) var appEnvironment: AppEnvironment
    @Inject(\.featureStore) var featureStore: any PFeatureStore
    
    // MARK: - Lifecycle
    @MainActor
    override func setUp() async throws {
        try await super.setUp()
        // Create a new feature store and set app environment
        featureStore.clearAll()
        mock(\.appEnvironment, mock: .development)
    }
    
    // MARK: - Tests
    
    // MARK: Registration tests
    func testStoreRegistersDependency() throws {
        let featureKey = "test_development_feature"
        
        // Register a feature
        featureStore.register(featureKey: featureKey, isEnabled: true)
        
        // Check our store registered correctly
        XCTAssertEqual(featureStore.features.count, 1)
        XCTAssertEqual(featureStore.features.first?.featureKey, featureKey)
    }
    
    func testStoreRegistersMultipleDependencies() throws {
        let featureKeyOne = "test_development_feature_one"
        let featureKeyTwo = "test_development_feature_two"
        
        // Register a feature
        featureStore.register(featureKey: featureKeyOne, isEnabled: true)
        featureStore.register(featureKey: featureKeyTwo, isEnabled: true)
        
        // Check our store registered correctly
        XCTAssertEqual(featureStore.features.count, 2)
        XCTAssertEqual(featureStore.features[0].featureKey, featureKeyOne)
        XCTAssertEqual(featureStore.features[1].featureKey, featureKeyTwo)
    }
    
    func testStoreRegistersDevelopmentKeyDependencyAsDevelopmentFlagType() throws {
        let featureKey = "test_development_feature"
        
        // Register a feature
        featureStore.register(featureKey: featureKey, isEnabled: true)
        
        // Check our store registered correctly
        XCTAssertEqual(featureStore.features.count, 1)
        XCTAssertEqual(featureStore.features.first?.flagType, .development)
    }
    
    func testStoreRegistersReleaseKeyDependencyAsReleaseFlagType() throws {
        let featureKey = "test_release_feature"
        
        // Register a feature
        featureStore.register(featureKey: featureKey, isEnabled: true)
        
        // Check our store registered correctly
        XCTAssertEqual(featureStore.features.count, 1)
        XCTAssertEqual(featureStore.features.first?.flagType, .release)
    }
    
    func testStoreRegistersPermissionKeyDependencyAsPermissionFlagType() throws {
        let featureKey = "test_permission_feature"
        
        // Register a feature
        featureStore.register(featureKey: featureKey, isEnabled: true)
        
        // Check our store registered correctly
        XCTAssertEqual(featureStore.features.count, 1)
        XCTAssertEqual(featureStore.features.first?.flagType, .permission)
    }
    
    func testStoreRegistersExperimentKeyDependencyAsExperimentFlagType() throws {
        let featureKey = "test_experiment_feature"
        
        // Register a feature
        featureStore.register(featureKey: featureKey, isEnabled: true)
        
        // Check our store registered correctly
        XCTAssertEqual(featureStore.features.count, 1)
        XCTAssertEqual(featureStore.features.first?.flagType, .experiment)
    }
    
    func testStoreRegistersFeatureFlagAsEnabled() throws {
        let featureKey = "test_feature"
        
        // Register a feature
        featureStore.register(featureKey: featureKey, isEnabled: true)
        
        // Check our store registered correctly
        XCTAssertEqual(featureStore.features.count, 1)
        XCTAssertEqual(featureStore.features.first?.isEnabled, true)
    }
    
    func testStoreRegistersFeatureFlagAsDisabled() throws {
        let featureKey = "test_feature"
        
        // Register a feature
        featureStore.register(featureKey: featureKey, isEnabled: false)
        
        // Check our store registered correctly
        XCTAssertEqual(featureStore.features.count, 1)
        XCTAssertEqual(featureStore.features.first?.isEnabled, false)
    }
    
    func testStoreRegistersFeatureFlagAsDisabledButUpdatesToEnabled() throws {
        let featureKey = "test_feature"
        
        // Register a feature
        featureStore.register(featureKey: featureKey, isEnabled: false)
        
        // Check our store registered correctly
        XCTAssertEqual(featureStore.features.count, 1)
        XCTAssertEqual(featureStore.features.first?.isEnabled, false)
        
        featureStore.update(feature: featureStore.features.first!, isEnabled: true)
        
        // Check if our store updated correctly
        XCTAssertEqual(featureStore.features.count, 1)
        XCTAssertEqual(featureStore.features.first?.isEnabled, true)
    }
    
    func testStoreDoesNotUpdateWhenFlagNotRegistered() throws {
        let featureKey = "test_feature"
        
        // Do not register a feature
        
        // Check our store registered correctly
        XCTAssertEqual(featureStore.features.count, 0)
        
        let otherToggle = FeatureToggle(featureKey: featureKey, flagType: .development, isEnabled: false)
        
        featureStore.update(feature: otherToggle, isEnabled: true)
        
        // Check our store did not update
        XCTAssertEqual(featureStore.features.count, 0)
    }
}
