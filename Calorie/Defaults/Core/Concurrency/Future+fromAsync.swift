//
//  File.swift
//  
//
//  Created by Justin Wilkin on 5/12/2022.
//

import Combine

extension Future where Failure == Error {
    public static func from(async: @escaping () async throws -> Output) -> AnyPublisher<Output, Failure> {
        return Future<Output, Failure> { promise in
            Task {
                do {
                    let result = try await async()
                    promise(.success(result))
                } catch {
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
