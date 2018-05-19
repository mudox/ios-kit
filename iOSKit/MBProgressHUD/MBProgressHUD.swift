import UIKit
import MBProgressHUD

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .debug)

extension MBProgressHUDMode: HasEnumNames {
  public static let enumName = "MBProgressHUDMode"

  public var caseName: String {
    switch self {
    case .text: return "text"
    case .indeterminate: return "indeterminate"
    case .determinate: return "determinate"
    case .annularDeterminate: return "annularDeterminate"
    case .determinateHorizontalBar: return "determinateHorizontalBar"
    case .customView: return "customView"
    }
  }
}

extension MBProgressHUDMode: CustomStringConvertible {
  public var description: String {
    return fullName
  }
}

extension MBProgressHUDBackgroundStyle: HasEnumNames {
  public static let enumName = "MBProgressHUDBackgroundStyle"

  public var caseName: String {
    switch self {
    case .blur: return "blur"
    case .solidColor: return "solidColor"
    }
  }
}

extension MBProgressHUDAnimation: HasEnumNames {
  public static let enumName = "MBProgressHUDAnimation"

  public var caseName: String {
    switch self {
    case .fade: return "fade"
    case .zoom: return "zoom"
    case .zoomOut: return "zoomOut"
    case .zoomIn: return "zoomIn"
    }
  }
}


extension MBProgressHUD {

  /// Convenient method to set component's foreground color in one step.
  ///
  /// - Important:
  ///   If a custom view is used, call this method __AFTER__ setting the custom view.
  ///
  /// - Parameter color: Foreground color to set.
  func setForeground(color: UIColor) {
    customView?.tintColor = color
    label.textColor = color
    detailsLabel.textColor = color
    button.setTitleColor(color, for: .normal)
  }

  func setBackground(color: UIColor) {
    bezelView.style = .solidColor
    bezelView.backgroundColor = color
  }

}
