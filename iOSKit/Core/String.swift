//
//  String.swift
//  iOSKit
//
//  Created by Mudox on 03/04/2018.
//

import Foundation

// MARK: - Common extension of `String` or `Substring`
extension StringProtocol where Index == String.Index {
  
  public func trimmed() -> String {
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  public var urlDecoded: String? {
    return removingPercentEncoding
  }
  
  public var urlEncoded: String? {
    return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }

}

// MARK: - Extension of `String`
extension String {
  
  public var base64Decoded: String? {
    guard let data = Data(base64Encoded: self) else { return nil }
    return String(data: data, encoding: .utf8)
  }
  
  public var base64Encoded: String? {
    return data(using: .utf8)?.base64EncodedString()
  }
  
}

extension Optional where Wrapped: StringProtocol {

  public var isNilOrEmpty: Bool {
    return self == nil || self!.isEmpty
  }

}

