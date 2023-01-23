//
//  NetworkError.swift
//  SwiftUI-MVS
//
//  Created by Justin Wilkin on 22/1/2023.
//

public enum RequestError: Error {
    case invalidUrl
}

extension RequestError: Equatable {
    public static func == (lhs: RequestError, rhs: RequestError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidUrl, invalidUrl):
            return true
        }
    }
}
