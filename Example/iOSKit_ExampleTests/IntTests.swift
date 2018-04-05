import XCTest
import Quick
import Nimble

@testable import iOSKit

class IntSpec: QuickSpec {
 override func spec() {

  describe("Int+TimeInterval") {

   it("return correct number of seconds") {
    expect(1.minuteInSecond) == 60
    expect(1.hourInSecond) == 60 * 60
    expect(1.dayInSecond) == 60 * 60 * 24
    expect(1.weekInSecond) == 60 * 60 * 24 * 7
   }

  }
 }
}
