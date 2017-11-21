//
//  Mudoxive.swift
//  MudoxKit
//
//  Created by Mudox on 14/08/2017.
//
//

/**
 Use `Mudoxive` proxy as customization point for constrained protocol extensions.

 General pattern would be:

   Extend Mudoxive protocol with constraints on Base
   Read as: Mudoxive Extension where Base is kind of SomeType

 Example Code:

 ```
  extension Mudoxive where Base: SomeType {
    // put any specific Mudoxive extension for SomeType here
  }
 ```

 With this approach we can have more specialized methods and properties using
 `Base` and not just specialized on common base type.

 */

public struct Mudoxive<Base> {
  /// Base object to extend.
  public let base: Base

  /// Creates extensions with base object.
  ///
  /// - parameter base: Base object.
  public init(_ base: Base) {
    self.base = base
  }
}

/// A type that has Mudoxive extensions.
public protocol MudoxiveCompatible {
  /// Extended type
  associatedtype CompatibleType

  /// Mudoxive extensions for the type.
  static var mdx: Mudoxive<CompatibleType>.Type { get set }

  /// Mudoxive extensions for instances.
  var mdx: Mudoxive<CompatibleType> { get set }
}

extension MudoxiveCompatible {
  /// Mudoxive extensions for the type.
  public static var mdx: Mudoxive<Self>.Type {
    get {
      return Mudoxive<Self>.self
    }
    set {
      // this enables using Mudoxive to "mutate" base type
    }
  }

  /// Mudoxive extensions for instances.
  public var mdx: Mudoxive<Self> {
    get {
      return Mudoxive(self)
    }
    set {
      // this enables using Mudoxive to "mutate" base object
    }
  }
}

import class Foundation.NSObject

/// Extend NSObject with `mdx` proxy.
extension NSObject: MudoxiveCompatible { }
