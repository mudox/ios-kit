//
//  CoreGraphics.swift
//  iOSKit
//
//  Created by Mudox on 01/04/2018.
//

import Foundation

extension CGSize {
  
  func aspectFit(to size: CGSize) -> CGSize {
    let wFactor = size.width / width
    let hFactor = size.height / height
    let factor = min(wFactor, hFactor)
    return CGSize(width: width * factor, height: height * factor)
  }

  func aspectFill(to size: CGSize) -> CGSize {
    let wFactor = size.width / width
    let hFactor = size.height / height
    let factor = max(wFactor, hFactor)
    return CGSize(width: width * factor, height: height * factor)
  }
  
}
