//
//  FeatureFlagServiceTests.swift
//  KineticTests
//
//  Created by Justin Wilkin on 27/12/2022.
//

import XCTest
import KineticInjection
@testable import kinetic

final class FeatureFlagServiceTests: XCTestCase, DependencyMocker {
    // MARK: - Mock objects
    struct MockRemoteConfig: PFeatureRemoteConfig {
        private var keys = [
            "flag_development_test_key": true,
            "flag_development_disabled_key": false
        ]
        
        func fetchAndActivate() {
            // Do nothing
        }
        
        func allKeys() -> [String] {
            return keys.map { $0.key }
        }
        
        func boolValue(for key: String) -> Bool {
            keys[key] ?? false
        }
    }
    
    // MARK: - Test objects
    @Inject(\.appEnvironment) var appEnvironment: AppEnvironment
    @Inject(\.featureStore) var featureStore: any PFeatureStore
    @Inject(\.featureFlagService) var featureFlagService: any PFeatureFlagService
    
    // MARK: - Lifecycle
    @MainActor
    override func setUp() async throws {
        try await super.setUp()
        // Erase our feature store and setup environment
        featureStore.clearAll()
        mock(\.appEnvironment, mock: .development)
        
        // Mock our remote config
        mock(\.featureRemoteConfig, mock: MockRemoteConfig())
    }
    
    // MARK: - Tests
    
    // MARK: Remote registration tests
    func testServiceRegistersRemoteFeatures() throws {
        featureFlagService.fetchFeatures()
        
        // Check our store registered correctly
        XCTAssertEqual(featureStore.features.count, 2)
        XCTAssertTrue(featureStore.features.contains(where: { $0.featureKey == "flag_development_test_key" }))
        XCTAssertTrue(featureStore.features.contains(where: { $0.featureKey == "flag_development_disabled_key" }))
    }
}

