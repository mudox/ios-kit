import XCTest
import Quick
import Nimble

@testable import iOSKit

class StringSpec: QuickSpec {
  override func spec() {

    describe("String") {

      it("trimmed") {
        let text = """
          hello world \t\n
          """
        expect(text.trimmed()) == "hello world"

        let subtext = Substring(text)
        expect(subtext.trimmed()) == "hello world"
      }

    } // describe("String")

    describe("Optional String") {

      it("isNilOrEmpty") {
        expect((nil as String?).isNilOrEmpty) == true
        expect(("" as String?).isNilOrEmpty) == true
        expect(("not empty" as String?).isNilOrEmpty) == false
      }

    } // describe("Optional String")

  }
}
