//
//  Errors.swift
//  Pods
//
//  Created by Mudox on 20/06/2017.
//
//

import Foundation

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .verbose)


public enum CommonError: Error {
  
  case cancelled
  
  case casting(Any?, to: Any.Type)
  
  case weakReferenceGone
  
  case error(String)
}
