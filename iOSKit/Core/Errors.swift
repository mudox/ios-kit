//
//  Errors.swift
//  Pods
//
//  Created by Mudox on 20/06/2017.
//
//

import Foundation

public enum MKError: Error {

  case assert(String)
  case result(Any?, expect: Any?)
  case nilSelf

  var localizedDescription: String {
    switch self {
    case let .assert(description):
      return "assertion failed: \(description)"
    case let .result(got, expect: want):
      return "unexpected result:\nexpect: \(String(describing: want))\ngot: \(String(describing: got))"
    case .nilSelf:
      return "self is released"
    }
  }
}
