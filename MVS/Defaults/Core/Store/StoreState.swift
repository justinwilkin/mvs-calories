//
//  StoreState.swift
//  
//
//  Created by Justin Wilkin on 17/11/2022.
//

import SwiftUI

public enum StoreState<DataType> {
    case loading(placeholder: DataType? = nil)
    case loaded(data: DataType)
    // TODO: Make this a view readable error for displaying
    case error(error: Error)
}

// MARK: - Convenience state updates
extension StoreState {
    public mutating func loading(with placeholder: DataType? = nil) {
        self = .loading(placeholder: placeholder)
    }
    
    public mutating func loaded(with data: DataType) {
        self = .loaded(data: data)
    }
    
    public mutating func error(with error: Error) {
        self = .error(error: error)
    }
}

extension StoreState {
    @ViewBuilder
    public func buildViewFromState(
        @ViewBuilder loadedBlock: (DataType) -> some View,
        @ViewBuilder loadingBlock: (DataType?) -> some View,
        @ViewBuilder errorBlock: (Error) -> some View
    ) -> some View {
        switch self {
        case .loaded(let loaded):
            loadedBlock(loaded)
        case .loading(let loading):
            loadingBlock(loading)
        case .error(let error):
            errorBlock(error)
        }
    }
    
    public var currentValue: DataType? {
        switch self {
        case .loaded(let loaded):
            return loaded
        default:
            return nil
        }
    }
}
