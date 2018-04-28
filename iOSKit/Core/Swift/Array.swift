import Foundation

extension Array {

  public subscript(guarded idx: Int) -> Element? {
    guard (startIndex..<endIndex).contains(idx) else {
      return nil
    }
    return self[idx]
  }

  public subscript(idx: Int, default defaultValue: Element) -> Element {
    guard (startIndex..<endIndex).contains(idx) else {
      return defaultValue
    }
    return self[idx]
  }

}
