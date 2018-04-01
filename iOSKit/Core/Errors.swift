//
//  Errors.swift
//  Pods
//
//  Created by Mudox on 20/06/2017.
//
//

import Foundation

public enum GeneralError: Error {

  case precondition(String)
  case unexpected(result: Any?, expect: Any?)
  case weakReleased

  var localizedDescription: String {
    switch self {
    case let .precondition(description):
      return "precondition failure: \(description)"
    case let .unexpected(result: got, expect: want):
      return "unexpected result:\nexpect: \(String(describing: want))\ngot: \(String(describing: got))"
    case .weakReleased:
      return "self is released"
    }
  }
}
