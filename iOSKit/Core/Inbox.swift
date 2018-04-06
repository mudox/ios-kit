//
//  Inbox.swift
//  Pods
//
//  Created by Mudox on 28/03/2017.
//
//

import Foundation

extension Bool {
  public mutating func toggle() {
    self = !self
  }
}

public func with<T>(_ target: T, apply change: (T) -> ()) {
  change(target)
}

public func with<T>(_ target: T, apply change: (T) throws -> ()) rethrows {
  try change(target)
}

public func with<T, Result>(_ target: T, evaluate: (T) -> Result) -> Result {
  return evaluate(target)
}

public func with<T, Result>(_ target: T, tryEvaluate evaluate: (T) throws -> Result) rethrows -> Result {
  return try evaluate(target)
}
