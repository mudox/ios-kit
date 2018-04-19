import Foundation

public extension Collection {

  /// Iteracte the collection element concurrently.
  ///
  /// - Parameter each: Closure to run through each element.
  public func forEachConcurrently(_ execute: (Self.Iterator.Element) -> Void) {
    let indicesArray = Array(indices)

    DispatchQueue.concurrentPerform(iterations: indicesArray.count) { (index) in
      let elementIndex = indicesArray[index]
      execute(self[elementIndex])
    }
  }

  /// Just return `nil` in case the index is out of bound.
  ///
  /// - Parameter index: The index to subscript.
  public subscript(safe index: Index) -> Iterator.Element? {
    return indices.contains(index) ? self[index] : nil
  }

}
