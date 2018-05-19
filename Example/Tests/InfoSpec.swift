import XCTest
import Quick
import Nimble

@testable import iOSKit

class InfoSpec: QuickSpec {
  override func spec() {

    describe("Info") {

      it("isSimulator") {
        #if targetEnvironment(simulator)
          expect(Info.isSimulator) == true
        #else
          expect(Info.isSimulator) == false
        #endif
      }
      it("isDebug") {
        #if DEBUG
          expect(Info.isDebug) == true
        #else
          expect(Info.isDebug) == false
        #endif
      }

    }
  }
}
