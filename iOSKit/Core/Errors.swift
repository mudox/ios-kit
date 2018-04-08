//
//  Errors.swift
//  Pods
//
//  Created by Mudox on 20/06/2017.
//
//

import Foundation

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .debug)


public enum TheError: Error {

  case precondition(String)
  case unexpected(result: Any?, expect: Any?)
  case weakReference

  var localizedDescription: String {
    switch self {
    case let .precondition(description):
      return "precondition failure: \(description)"
    case let .unexpected(result: got, expect: want):
      return "unexpected result:\n  expect: \(String(describing: want))\n  got: \(String(describing: got))"
    case .weakReference:
      return "weakly captured reference is released"
    }
  }
}
