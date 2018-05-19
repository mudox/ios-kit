public func with<T>(_ target: T, apply: (T) throws -> ()) rethrows {
  try apply(target)
}

public func with<T, Result>(_ target: T, evaluate: (T) throws -> Result) rethrows -> Result {
  return try evaluate(target)
}
