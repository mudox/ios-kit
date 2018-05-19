//
//  File.swift
//  iOSKit
//
//  Created by Mudox on 2018/4/7.
//

import UIKit

protocol HasEnumNames {

  static var enumName: String { get }
  var fullName: String { get }
  var caseName: String { get }

}

extension HasEnumNames {

  public var fullName: String {
    return "\(Self.enumName).\(caseName)"
  }

}

extension UIAlertControllerStyle: HasEnumNames {

  public static let enumName = "UIAlertControllerStyle"

  public var caseName: String {
    switch self {
    case .actionSheet: return "actionSheet"
    case .alert: return "alert"
    }
  }

}

extension UIImagePickerControllerSourceType: HasEnumNames {

  public static let enumName = "UIImagePickerControllerSourceType"

  public var caseName: String {
    switch self {
    case .camera: return "camera"
    case .photoLibrary: return "photoLibrary"
    case .savedPhotosAlbum: return "savedPhotosAlbum"
    }
  }
  
}
