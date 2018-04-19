import XCTest
import Quick
import Nimble

@testable import iOSKit

class IntSpec: QuickSpec {
  override func spec() {

    describe("Int") {

      it("minute hour day week") {
        expect(1.minute) == 60
        expect(1.hour) == 60 * 60
        expect(1.day) == 60 * 60 * 24
        expect(1.week) == 60 * 60 * 24 * 7
      }

      it("kb mb gb tb") {
        expect(1.kb) == 1024
        expect(1.mb) == 1024 * 1024
        expect(1.gb) == 1024 * 1024 * 1024
        expect(1.tb) == 1024 * 1024 * 1024 * 1024
      }
      
    } // describe("Int")
    
  }
}
