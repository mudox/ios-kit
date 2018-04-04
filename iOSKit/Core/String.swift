//
//  String.swift
//  iOSKit
//
//  Created by Mudox on 03/04/2018.
//

import Foundation

extension String {
  public func trimmed() -> String {
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
  }
}
