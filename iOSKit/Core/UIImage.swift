import UIKit

extension UIImage {

  
  /// Generate a image filled with a single color. Typically used for
  /// control background image.
  ///
  /// - Parameters:
  ///   - color: Color to fill.
  ///   - size: Defaults to 1x1 pixel
  public convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
    
    UIGraphicsBeginImageContextWithOptions(size, false, 1) // `size` is pixels
    defer { UIGraphicsEndImageContext() }

    color.setFill()
    UIRectFill(CGRect(origin: .zero, size: size))

    guard let image = UIGraphicsGetImageFromCurrentImageContext(), let aCGImage = image.cgImage else {
      self.init()
      return
    }
    
    self.init(cgImage: aCGImage)
  }
  
}
