//
//  SwiftJSON.swift
//  AiGou
//
//  Created by Mudox on 12/08/2017.
//  Copyright © 2017 Mudox. All rights reserved.
//

import Foundation
import SwiftyJSON

enum JSONMappingError: Swift.Error {
  case type(String)
  case path(String)
}

extension JSON {

  private func operationDescription(for path: [JSONSubscriptType], getterName: String) -> String {
    let path = path.map { String(reflecting: $0) }.joined(separator: ", ")
    return "json[\(path)].\(getterName).error"
  }

  private func pathError(getter: JSON, path: [JSONSubscriptType], getterName: String) -> Error {
    return JSONMappingError.path("\(operationDescription(for: path, getterName: getterName)): \(getter.error!.localizedDescription)")
  }

  private func typeError(path: [JSONSubscriptType], targetType: String, sourceType: String) -> Error {
    var getterName: String
    switch targetType {
    case "String", "String?": getterName = "string"
    case "Int", "Int?": getterName = "int"
    case "Int64", "Int64?": getterName = "int64"
    case "Int32", "Int32?": getterName = "int32"
    case "Int16", "Int16?": getterName = "int16"
    case "Int8", "Int8?": getterName = "int8"
    default: getterName = "unknown targetType (\(targetType))"
    }
    return JSONMappingError.path("\(operationDescription(for: path, getterName: getterName)): Ask \(targetType) on \(sourceType) value")
  }

  // MARK: - Int, Int?

  public func take(from path: [JSONSubscriptType]) throws -> Int? {
    let getter = self[path]
    guard getter.error == nil else {
      throw pathError(getter: getter, path: path, getterName: "int")
    }

    switch getter.type {
    case .null, .number:
      return getter.int
    default:
      throw typeError(path: path, targetType: "Int?", sourceType: "\(getter.type)")
    }
  }

  public func take(from path: JSONSubscriptType...) throws -> Int? {
    return try take(from: path)
  }

  public func take(from path: JSONSubscriptType...) throws -> Int {
    if let value: Int = try take(from: path) {
      return value
    } else {
      throw typeError(path: path, targetType: "Int", sourceType: "nil")
    }
  }

  // MARK: - Int64, Int64?

  public func take(from path: [JSONSubscriptType]) throws -> Int64? {
    let getter = self[path]
    guard getter.error == nil else {
      throw pathError(getter: getter, path: path, getterName: "int64")
    }

    switch getter.type {
    case .null, .number:
      return getter.int64
    default:
      throw typeError(path: path, targetType: "Int64?", sourceType: "\(getter.type)")
    }
  }

  public func take(from path: JSONSubscriptType...) throws -> Int64? {
    return try take(from: path)
  }

  public func take(from path: JSONSubscriptType...) throws -> Int64 {
    if let value: Int64 = try take(from: path) {
      return value
    } else {
      throw typeError(path: path, targetType: "Int64", sourceType: "nil")
    }
  }

  // MARK: - Int32, Int32?

  public func take(from path: [JSONSubscriptType]) throws -> Int32? {
    let getter = self[path]
    guard getter.error == nil else {
      throw pathError(getter: getter, path: path, getterName: "int32")
    }

    switch getter.type {
    case .null, .number:
      return getter.int32
    default:
      throw typeError(path: path, targetType: "Int32?", sourceType: "\(getter.type)")
    }
  }

  public func take(from path: JSONSubscriptType...) throws -> Int32? {
    return try take(from: path)
  }

  public func take(from path: JSONSubscriptType...) throws -> Int32 {
    if let value: Int32 = try take(from: path) {
      return value
    } else {
      throw typeError(path: path, targetType: "Int32", sourceType: "nil")
    }
  }

  // MARK: - Int16, Int16?

  public func take(from path: [JSONSubscriptType]) throws -> Int16? {
    let getter = self[path]
    guard getter.error == nil else {
      throw pathError(getter: getter, path: path, getterName: "int16")
    }

    switch getter.type {
    case .null, .number:
      return getter.int16
    default:
      throw typeError(path: path, targetType: "Int16?", sourceType: "\(getter.type)")
    }
  }

  public func take(from path: JSONSubscriptType...) throws -> Int16? {
    return try take(from: path)
  }

  public func take(from path: JSONSubscriptType...) throws -> Int16 {
    if let value: Int16 = try take(from: path) {
      return value
    } else {
      throw typeError(path: path, targetType: "Int16", sourceType: "nil")
    }
  }

  // MARK: - Int8, Int8?

  public func take(from path: [JSONSubscriptType]) throws -> Int8? {
    let getter = self[path]
    guard getter.error == nil else {
      throw pathError(getter: getter, path: path, getterName: "int8")
    }

    switch getter.type {
    case .null, .number:
      return getter.int8
    default:
      throw typeError(path: path, targetType: "Int8?", sourceType: "\(getter.type)")
    }
  }

  public func take(from path: JSONSubscriptType...) throws -> Int8? {
    return try take(from: path)
  }

  public func take(from path: JSONSubscriptType...) throws -> Int8 {
    if let value: Int8 = try take(from: path) {
      return value
    } else {
      throw typeError(path: path, targetType: "Int8", sourceType: "nil")
    }
  }

  // MARK: - String, String?

  public func take(from path: [JSONSubscriptType]) throws -> String? {
    let getter = self[path]
    guard getter.error == nil else {
      throw pathError(getter: getter, path: path, getterName: "string")
    }

    switch getter.type {
    case .null, .string:
      return getter.string
    default:
      throw typeError(path: path, targetType: "String?", sourceType: "\(getter.type)")
    }
  }

  public func take(from path: JSONSubscriptType...) throws -> String? {
    return try take(from: path)
  }

  public func take(from path: JSONSubscriptType...) throws -> String {
    if let value: String = try take(from: path) {
      return value
    } else {
      throw typeError(path: path, targetType: "String", sourceType: "nil")
    }
  }

  // MARK: - Array, Array?

  public func take(from path: [JSONSubscriptType]) throws -> [JSON]? {
    let getter = self[path]
    guard getter.error == nil else {
      throw pathError(getter: getter, path: path, getterName: "array")
    }

    switch getter.type {
    case .null, .array:
      return getter.array
    default:
      throw typeError(path: path, targetType: "[JSON]?", sourceType: "\(getter.type)")
    }
  }

  public func take(from path: JSONSubscriptType...) throws -> [JSON]? {
    return try take(from: path)
  }

  public func take(from path: JSONSubscriptType...) throws -> [JSON] {
    if let value: [JSON] = try take(from: path) {
      return value
    } else {
      throw typeError(path: path, targetType: "[JSON]", sourceType: "nil")
    }
  }
}
