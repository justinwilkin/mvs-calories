//
//  PStore.swift
//  kinetic
//
//  Created by Justin Wilkin on 3/10/2022.
//

import Combine

typealias AnyTask = Task<Any, Never>
protocol PStore: AnyObservableObject, ObservableObject {
    var tasks: Set<AnyTask> { get }
    var disposables: Set<AnyCancellable> { get }
    func setup()
    func setupBindings()
    func cancel()
}
