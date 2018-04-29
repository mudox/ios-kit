import XCTest
import Quick
import Nimble

@testable import iOSKit

class OptionalSpec: QuickSpec {
  override func spec() {

    fdescribe("Optional") {

      it("triple question mark opterator") {
        let a: Int? = nil
        expect(a ??? "nil value") == "nil value"
        let b: Int? = 1
        expect(b ??? "nil value") == String(describing: b!)
      }

      // FIXME: as for Xcode 9.3, trap() can not be captured by Nimble
      it("doubble esclamation mark operator") {
        expect((12 as Int?) !! "Should throw") == 12
      }

      // FIXME: as for Xcode 9.3, trap() can not be captured by Nimble
      it("iterrobang operator") {
        
        expect((1 as Int?) !? "Should not show it") == 1
        expect((1 as Int?) !? (100, "Should not show it")) == 1
        
        expect(("abc" as String?) !? "Should return \"abc\"") == "abc"
        expect(("abc" as String?) !? ("xyz", "Should return \"abc\"")) == "abc"

        expect(([1, 2] as [Int]?) !? "Should return [1, 2]") == [1, 2]
        expect(([1, 2] as [Int]?) !? ([100, 101], "Should return [1, 2]")) == [1, 2]

      }

    }
  }

}
