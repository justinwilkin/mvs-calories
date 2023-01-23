//
//  FeatureStoreRecallTests.swift
//  KineticTests
//
//  Created by Justin Wilkin on 27/12/2022.
//

import XCTest
import SwiftUI
import KineticInjection
@testable import kinetic

final class FeatureStoreRecallTests: XCTestCase, DependencyMocker {
    // MARK: - Mock objects
    public enum TestFeatures: String, Feature {
        // MARK: Energy tab
        case developmentEnabledFeature = "test_development_enabled_feature"
        case developmentDisabledFeature = "test_development_disabled_feature"
        case releaseEnabledFeature = "test_release_enabled_feature"
        case releaseDisabledFeature = "test_release_disabled_feature"
        case releaseNotRegisteredFeature = "test_release_not_registered_feature"
        case otherNotRegisteredFeature = "test_debug_not_registered_feature"
    }

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
        
        // Register features
        featureStore.register(featureKey: TestFeatures.developmentEnabledFeature.remoteKey, isEnabled: true)
        featureStore.register(featureKey: TestFeatures.developmentDisabledFeature.remoteKey, isEnabled: false)
        featureStore.register(featureKey: TestFeatures.releaseEnabledFeature.remoteKey, isEnabled: true)
        featureStore.register(featureKey: TestFeatures.releaseDisabledFeature.remoteKey, isEnabled: false)
    }
    
    // MARK: - Tests
    
    // MARK: Recall tests
    func testFeatureRecallDependenciesEnabledAndDisabledInDevelopmentBuild() throws {
        // Set our app to development
        mock(\.appEnvironment, mock: .development)
        
        // Verify features are recalled correctly
        XCTAssertTrue(TestFeatures.developmentEnabledFeature.isEnabled)
        XCTAssertFalse(TestFeatures.developmentDisabledFeature.isEnabled)
        XCTAssertTrue(TestFeatures.releaseEnabledFeature.isEnabled)
        XCTAssertFalse(TestFeatures.releaseDisabledFeature.isEnabled)
    }
    
    func testFeatureRecallDependenciesDisabledInProductionBuild() throws {
        // Set our app to production
        mock(\.appEnvironment, mock: .production)
        
        // Verify features are recalled correctly
        XCTAssertFalse(TestFeatures.developmentEnabledFeature.isEnabled)
        XCTAssertFalse(TestFeatures.developmentDisabledFeature.isEnabled)
        XCTAssertTrue(TestFeatures.releaseEnabledFeature.isEnabled)
        XCTAssertFalse(TestFeatures.releaseDisabledFeature.isEnabled)
    }
    
    func testFeatureActionInvokeWhenEnabled() {
        // Set our app to development
        mock(\.appEnvironment, mock: .development)
        
        var didInvoke = false
        
        TestFeatures.releaseEnabledFeature.enabled {
            didInvoke = true
        }
        
        // Verify block was invoked
        XCTAssertTrue(didInvoke)
    }
    
    func testFeatureActionDoesNotInvokeWhenDisabled() {
        // Set our app to development
        mock(\.appEnvironment, mock: .development)
        
        var didInvoke = false
        
        TestFeatures.releaseDisabledFeature.enabled {
            didInvoke = true
        }
        
        // Verify block was not invoked
        XCTAssertFalse(didInvoke)
    }
    
    func testFeatureActionInvokesWhenReleaseFlagNotFound() {
        // Set our app to development
        mock(\.appEnvironment, mock: .production)
        
        var didInvoke = false
        
        TestFeatures.releaseNotRegisteredFeature.enabled {
            didInvoke = true
        }
        
        // Verify block was invoked
        XCTAssertTrue(didInvoke)
    }
    
    func testFeatureActionDoesNotInvokesWhenOtherFlagNotFound() {
        // Set our app to development
        mock(\.appEnvironment, mock: .development)
        
        var didInvoke = false
        
        TestFeatures.otherNotRegisteredFeature.enabled {
            didInvoke = true
        }
        
        // Verify block was not invoked
        XCTAssertFalse(didInvoke)
    }
    
    func testSwiftUIViewBuiltWhenFlagFound() {
        // Set our app to development
        mock(\.appEnvironment, mock: .development)
        
        let view: some View = TestFeatures.developmentEnabledFeature.enabled {
            Text("some view")
        }
        
        XCTAssertNotNil(view)
    }
}

