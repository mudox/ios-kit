import XCTest
import Quick
import Nimble

@testable import iOSKit

class TheSpec: QuickSpec {
  override func spec() {
    
    describe("The.info") {
      
      it("isSimulator") {
        #if targetEnvironment(simulator)
        expect(The.info.isSimulator) == true
        #else
        expect(The.info.isSimulator) == false
        #endif
      }
        it("isDebug") {
        #if DEBUG
        expect(The.info.isDebug) == true
        #else
        expect(The.info.isDebug) == false
        #endif
      }
      
    } // describe("The")
    
  }
}
