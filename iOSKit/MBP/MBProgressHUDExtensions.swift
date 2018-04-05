import UIKit
import MBProgressHUD

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .debug)

extension MBProgressHUD {
  
  /// Convenient method to set component's foreground color in one step.
  ///
  /// - Important:
  ///   If a custom view is used, call this method __AFTER__ setting the custom view.
  ///
  /// - Parameter color: Foreground color to set.
  func setForegroundColor(_ color: UIColor) {
    customView?.tintColor = color
    label.textColor = color
    detailsLabel.textColor = color
    button.setTitleColor(color, for: .normal)
  }

  func setBackgroundColor(_ color: UIColor) {
    bezelView.style = .solidColor
    bezelView.backgroundColor = color
  }
  
}
