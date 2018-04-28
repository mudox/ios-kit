import XCTest
import Quick
import Nimble

@testable import iOSKit

class OptionalSpec: QuickSpec {
  override func spec() {

    describe("Optional") {

      it("triple question mark opterator") {
        let a: Int? = nil
        expect(a ??? "nil value") == "nil value"
        let b: Int? = 1
        expect(b ??? "nil value") == String(describing: b!)
      }

    }
  }
}

