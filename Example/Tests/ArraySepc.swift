import XCTest
import Quick
import Nimble

@testable import iOSKit

class ArraySpec: QuickSpec {
  override func spec() {

    describe("Array") {

      it("guarded subscript operator") {
        let a = [1, 2, 3]
        expect(a[guarded: 1]) == 2
        expect(a[guarded: 100]).to(beNil())
      }
      
      it("subscript with default value") {
        let a = [1, 2, 3]
        expect(a[1, default: 3]) == 2
        expect(a[100, default: -1]) == -1
      }

    } // describe("Int")

  }
}
