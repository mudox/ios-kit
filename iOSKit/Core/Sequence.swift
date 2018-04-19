import Foundation


public extension Sequence {
  
  /// Returns `true` if all elements in the sequence satisfy the predicate.
  ///
  /// - Parameter predicate: The predicate closure.
  /// - Returns: `true` if all elements in the sequence satisfies the predicate.
  public func all(matching predicate: (Element) throws -> Bool) rethrows -> Bool {
    return try !contains { try !predicate($0) }
  }
  
  /// Returns `true` if no element in the sequence satisfies the predicate.

  ///
  /// - Parameter predicate: The predicate closure.
  /// - Returns: `true` if no element in the sequence satisfies the predicate.
  public func none(matching predicate: (Element) throws -> Bool) rethrows -> Bool {
    return try !contains { try predicate($0) }
  }
  
  /// Returns `true` if any element in the sequence satisfies the predicate.

  ///
  /// - Parameter predicate: The predicate closure.
  /// - Returns: `true` if all elements in the sequence satisfy the predicate.
  public func any(matching predicate: (Element) throws -> Bool) rethrows -> Bool {
    return try contains { try predicate($0) }
  }
  
}
