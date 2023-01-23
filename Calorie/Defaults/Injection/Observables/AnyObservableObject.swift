//
//  AnyObservableObject.swift
//  kinetic
//
//  Created by Justin Wilkin on 5/10/2022.
//

import Combine

public protocol AnyObservableObject: AnyObject {
    var objectWillChange: ObservableObjectPublisher { get }
}
