//
//  MergingStrategies.swift
//  SwiftUI-MVS
//
//  Created by Justin Wilkin on 22/1/2023.
//

import Foundation

enum MergingStrategy<Value> { }

extension MergingStrategy {
  typealias KeepOld = Value
  typealias OverwriteOld = Value

  /// Overwrite the original value.
  static var overwrite: (KeepOld, OverwriteOld) -> Value {
    { $1 }
  }
}
