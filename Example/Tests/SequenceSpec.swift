import XCTest
import Quick
import Nimble

@testable import iOSKit

class SequenceSpec: QuickSpec {
  override func spec() {

    describe("Sequence") {
      
      let allTrue = [Bool](repeating: true, count: 10)
      let allFalse = [Bool](repeating: false, count: 10)
      let list1 = [true, false, true, false, false]
      let list2 = [1, 2, 12, 2, 0, 3, 0, -2, 12, 1]

      it("all") {
        expect(allTrue.all(matching: { $0 == true })) == true
        expect(allFalse.all(matching: { $0 == false })) == true
        expect(list1.all(matching: { $0 == true })) == false
      }

      it("any") {
        expect(allTrue.any(matching: { $0 == true })) == true
        expect(allFalse.any(matching: { $0 == true })) == false
        expect(list1.any(matching: { $0 == true })) == true
      }
      
      it("none") {
        expect(allTrue.none(matching: { $0 == true })) == false
        expect(allFalse.none(matching: { $0 == true })) == true
        expect(list1.none(matching: { $0 == true })) == false
      }
      
      it("unique") {
        expect(list2.unique()) == [1, 2, 12, 0, 3, -2]
      }
      
    } // describe("Int")
    
  }
}
