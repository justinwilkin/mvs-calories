//
//  Repository.swift
//  SwiftUI-MVS
//
//  Created by Justin Wilkin on 22/1/2023.
//

import Combine
import Foundation

protocol Repository {
    func perform<Decode: Decodable>(
        _ method: HttpMethod,
        url: String,
        headers: [String: String]
    ) -> AnyPublisher<Decode, Error>
}

extension Repository {
    
    /// Builds a network request and processes it
    ///
    /// Creates a request with the appropriate `HttpMethod` and processes
    /// the request
    ///
    /// - Parameters:
    ///     - method:  The `HttpMethod` to be used with the request
    ///
    ///  - Returns: A publisher with the decodable type provided by user, and ApiError as failure
    public func perform<Decode: Decodable>(
        _ method: HttpMethod,
        url: String,
        headers: [String: String] = [:]
    ) -> AnyPublisher<Decode, Error> {
        var request = try! build(url: url)
        addHeaders(&request, headers: headers)
        setMethod(&request, method: method)
        
        // Return a network publisher
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Decode.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    // MARK: - Private helpers
    private func build(url: String) throws -> URLRequest {
        guard let builtUrl = URL(string: url) else {
            throw RequestError.invalidUrl
        }

        return URLRequest(url: builtUrl)
    }
    
    private func setMethod(_ request: inout URLRequest, method: HttpMethod) {
        request.httpMethod = method.rawValue
        request.httpBody = method.body
    }
    
    private func addHeaders(_ request: inout URLRequest, headers: [String: String]) {
        // Add headers to the request overrwriting defaults
        let requestHeaders = Headers.default.merging(
            headers,
            uniquingKeysWith: MergingStrategy.overwrite
        )

        requestHeaders.forEach { header in
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
    }
}

