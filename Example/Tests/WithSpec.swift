import XCTest
import Quick
import Nimble

import UIKit
@testable import iOSKit

class WithSpec: QuickSpec {
  override func spec() {

    describe("With") {

      it("creates and configures a view") {
        expect {
          let _ = with(UIView()) { view in
            view.layer.cornerRadius = 3
            view.layer.masksToBounds = true
            view.layer.borderWidth = 1
            view.layer.borderColor = UIColor.green.cgColor
          }
          return ()
        }.toNot(throwError())
      }

    }
  }
}
