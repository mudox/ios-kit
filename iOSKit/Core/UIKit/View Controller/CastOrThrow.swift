import RxSwift
import RxCocoa

/// Cast or throw.
///
/// - Parameters:
///   - object: Object to be casted from.
///   - type: Target type.
/// - Returns: The optinal value if casting succeeded.
/// - Throws: `CommonError.casting`
func cast<T>(_ object: Any?, to type: T.Type) throws -> T {
  guard let result = object as? T else {
    throw CommonError.casting(object, to: type)
  }
  
  return result
}

/// Cast or throw. This version casts NSNull() to nil.
///
/// - Parameters:
///   - object: Object to be casted from.
///   - type: Target type.
/// - Returns: The optinal value if casting succeeded.
/// - Throws: `CommonError.casting`
func cast<T>(_ object: Any?, to type: Optional<T>.Type) throws -> Optional<T> {
  if NSNull().isEqual(object) {
    return nil
  }
  
  guard let returnValue = object as? T else {
    throw CommonError.casting(object, to: type)
  }
  
  return returnValue
}
