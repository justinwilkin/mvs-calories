//
//  Disposables+cancel.swift
//  kinetic
//
//  Created by Justin Wilkin on 12/10/2022.
//

import Combine

extension Collection where Element: AnyCancellable {
    public func cancel() {
        self.forEach { disposable in
            disposable.cancel()
        }
    }
}

extension Collection where Element == AnyTask {
    func cancel() {
        self.forEach { task in
            task.cancel()
        }
    }
}
