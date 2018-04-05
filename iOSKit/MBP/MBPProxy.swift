import UIKit
import MBProgressHUD
import JacKit

public struct MBPProxy<Base> {
  /// Base object to extend.
  public let base: Base

  /// Creates extensions with base object.
  ///
  /// - parameter base: Base object.
  public init(_ base: Base) {
    self.base = base
  }
}

/// A type that has `mbp` extensions.
public protocol MBPHost {
  /// Extended type
  associatedtype MBPHostType

  /// MBPProxy extensions.
  static var mbp: MBPProxy<MBPHostType>.Type { get set }

  /// MBPProxy extensions.
  var mbp: MBPProxy<MBPHostType> { get set }
}

extension MBPHost {
  /// MBPProxy extensions.
  public static var mbp: MBPProxy<Self>.Type {
    get {
      return MBPProxy<Self>.self
    }
    set {
      // this enables using MBPProxy to "mutate" base type
    }
  }

  /// MBPProxy extensions.
  public var mbp: MBPProxy<Self> {
    get {
      return MBPProxy(self)
    }
    set {
      // this enables using MBPProxy to "mutate" base object
    }
  }
}

import class UIKit.UIView

/// Extend NSObject with `mbp` proxy.
extension UIView: MBPHost { }
