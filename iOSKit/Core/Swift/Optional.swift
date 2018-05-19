import Foundation

// MARK: - Operator ???

infix operator ???: NilCoalescingPrecedence

/// Operator ???
/// Similar as the nil coaleascing operator `??`, but always return a String.
/// Typically used for output.
///
///     var a: Int? = nil
///     print("a: \(a ??? "nil")")
///
/// - Parameters:
///   - optional: The optional value.
///   - elseString: Fall back string if the optional value is nil.
/// - Returns: The string that describing the optional value.
public func ???<T>(optional: T?, elseString: @autoclosure () -> String) -> String
{
  switch optional {
  case let value?: return String(describing: value)
  case nil: return elseString()
  }
}

// MARK: - Operator !!

infix operator !!

/// Operator !!
/// Improve the message show when force-unwrapping fails.
///
/// - Parameters:
///   - wrapped: The optional value.
///   - failureDescription: The custom failure message.
/// - Returns: The unwraped value if any.
func !! <T>(wrapped: T?, failureDescription: @autoclosure () -> String) -> T {
  if let unwrapped = wrapped {
    return unwrapped
  } else {
    fatalError(failureDescription())
  }
}

// MARK: - Operator !?

infix operator !?

/// Operator !?
/// If the left operand is nil, panic with specified message in debug mode,
/// while return a fallback value in release mode.
///
/// - Parameters:
///   - wrapped: The optional value to force unwrap conditionally.
///   - failure.value: The fallback value returned in release mode.
///   - failure.description: The exception description printed out in debug mode.
/// - Returns: The wrapped value if is not nil.
func !?<T> (
  wrapped: T?,
  _ failure: @autoclosure () -> (value: T, description: String)
) -> T {
  assert(wrapped != nil, failure().description)
  return wrapped ?? failure().value
}

func !?<T: ExpressibleByIntegerLiteral>
(wrapped: T?, failureDescription: @autoclosure () -> String) -> T
{
  assert(wrapped != nil, failureDescription())
  return wrapped ?? 0
}

func !?<T: ExpressibleByStringLiteral>
(wrapped: T?, failureDescription: @autoclosure () -> String) -> T
{
  assert(wrapped != nil, failureDescription)
  return wrapped ?? ""
}

func !?<T: ExpressibleByArrayLiteral>
  (wrapped: T?, failureDescription: @autoclosure () -> String) -> T
{
  assert(wrapped != nil, failureDescription())
  return wrapped ?? []
}

func !?<T: ExpressibleByDictionaryLiteral>
  (wrapped: T?, failureDescription: @autoclosure () -> String) -> T
{
  assert(wrapped != nil, failureDescription())
  return wrapped ?? [:]
}

func !?(wrapped: ()?, failureText: @autoclosure () -> String) {
  assert(wrapped != nil, failureText)
}
