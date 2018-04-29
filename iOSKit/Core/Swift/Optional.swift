import Foundation

// MARK: - Operator ???

infix operator ???: NilCoalescingPrecedence

public func ???<T>(optional: T?, elseString: @autoclosure () -> String) -> String
{
  switch optional {
  case let value?: return String(describing: value)
  case nil: return elseString()
  }
}

// MARK: - Operator !!

infix operator !!

/// Operator !!, improve the message show when force-unwrap fails.
///
/// - Parameters:
///   - wrapped: The optional to force-unwrap.
///   - failureDescription: The custom failure message.
/// - Returns: The unwraped value if any.
func !! <T>(wrapped: T?, failureDescription: @autoclosure () -> String) -> T {
  if let x = wrapped {
    return x
  } else {
    fatalError(failureDescription())
  }
}

// MARK: - Operator !?

infix operator !?

/// Operator !?, if the left operand is nil, panic with specified message in debug, reutrn a fallback value in release mode.
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
