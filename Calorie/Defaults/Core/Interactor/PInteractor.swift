//
//  PInteractor.swift
//  kinetic
//
//  Created by Justin Wilkin on 11/10/2022.
//

import Combine

public protocol PInteractor {
    var disposables: Set<AnyCancellable> { get }
    func setup()
    func setupBindings()
    func update()
    func cancel()
}
