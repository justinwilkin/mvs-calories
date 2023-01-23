//
//  Publisher+mapEvents.swift
//  SwiftUI-MVS
//
//  Created by Justin Wilkin on 23/1/2023.
//

import Combine
import Foundation

extension Publisher where Failure == Error {
    /// Map our publisher events and results to completion handlers
    ///
    /// Since an inout StoreState cannot be captured in an escaping closure
    /// State update callbacks can be passed in instead.
    public func mapEvents(
        successBlock: @escaping (Output) -> Void,
        loadingBlock: @escaping () -> Void,
        errorBlock: @escaping (Error) -> Void
    ) -> AnyCancellable {
        self.handleEvents(
            // Start loading on initial subscription
            receiveSubscription: { _ in
                // Run our block on the main thread as it will typically fire state changes
                DispatchQueue.main.async {
                    loadingBlock()
                }
            }
        )
        .sink { completion in
            // Errors will automatically complete
            switch completion {
            case .finished:
                break
            case .failure(let error):
                errorBlock(error)
            }
        } receiveValue: { output in
            // Forward our success
            successBlock(output)
        }
    }
}
