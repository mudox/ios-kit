import UIKit

extension Mudoxive where Base: UIBarButtonItem {
  
  public static func makeFlexibleSpace() -> UIBarButtonItem {
    return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
  }
  
  public static func makeFixedSpace(width: CGFloat) -> UIBarButtonItem {
    let item =  UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
    item.width = width
    return item
  }
  
}
