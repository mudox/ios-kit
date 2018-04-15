import Foundation

import JacKit
fileprivate let jack = Jack.with(fileLocalLevel: .verbose)

private class _ThisFramework { } // for retrieving the framework bundle
private let _name = "mbp"

extension Bundle {

  static var assets: Bundle = {
    let frameworkBundle = Bundle(for: _ThisFramework.self)
    let assetsBundleURL = frameworkBundle.url(forResource: _name, withExtension: "bundle")!
    return Bundle(url: assetsBundleURL)!
  }()

}

extension UIImage {

  static var checkMark: UIImage {
    if let image = UIImage(named: "Check37", in: Bundle.assets, compatibleWith: nil) {
      return image
    } else {
      jack.failure("Loading image `Check37` failed")
      return UIImage()
    }
  }

  static var crossMark: UIImage {
    if let image = UIImage(named: "Cross37", in: Bundle.assets, compatibleWith: nil) {
      return image
    } else {
      jack.failure("Loading image `Cross37` failed")
      return UIImage()
    }
  }

}

extension UIColor {
  
  static let success = UIColor(red: 0.205, green: 0.450, blue: 0.142, alpha: 1)
  
  static let failure = UIColor(red: 0.800, green: 0.078, blue: 0.034, alpha: 1)
  
}
