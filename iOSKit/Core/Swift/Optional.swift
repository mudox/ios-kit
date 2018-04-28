import Foundation

infix operator ???: NilCoalescingPrecedence

public func ???<T>(optional: T?, elseString: @autoclosure () -> String) -> String
{
  switch optional {
  case let value?: return String(describing: value)
  case nil: return elseString()
  }
}
