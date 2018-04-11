import XCTest
import Quick
import Nimble

@testable import iOSKit

class IntSpec: QuickSpec {
  override func spec() {

    describe("Int") {

      it("can express time units") {
        expect(1.minuteInSecond) == 60
        expect(1.hourInSecond) == 60 * 60
        expect(1.dayInSecond) == 60 * 60 * 24
        expect(1.weekInSecond) == 60 * 60 * 24 * 7
      }

      it("can expresss bytes size") {
        expect(1.KB) == 1024
        expect(1.MB) == 1024 * 1024
        expect(1.GB) == 1024 * 1024 * 1024
        expect(1.TB) == 1024 * 1024 * 1024 * 1024
      }
    }
  }
}
