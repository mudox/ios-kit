import XCTest
import Quick
import Nimble

@testable import iOSKit

class AlertLayoutSpec: QuickSpec {
  override func spec() {

    describe("AlertLayout") {

      it("throws on empty input") {
        let layout = ""
        expect { _ = try AlertLayout(layout: layout) } .to(throwError())
      }

      it("accepts bare title") {
        let layout = "title"
        let expected = AlertLayout(title: "title", message: nil, actions: [.fallback])
        var result: AlertLayout?
        expect { result = try AlertLayout(layout: layout) } .toNot(throwError())
        expect(result) == expected
      }

      it("accepts bare message") {
        let layout = ":message"
        let expected = AlertLayout(title: nil, message: "message", actions: [.fallback])
        var result: AlertLayout?
        expect { result = try AlertLayout(layout: layout) } .toNot(throwError())
        expect(result) == expected
      }

      it("accepts bare actions") {
        let layout = "->action1|action2"
        expect { _ = try AlertLayout(layout: layout) }.to(throwError(AlertLayout.Errors.needTitleOrMessage))
      }

      it("accepts title and actions") {
        let layouts = [
          "title->[c]",
          "title->act||",
          "title->act1|[d]|act2",
        ]
        try! layouts.forEach { layout in
          print("🎾 feed \(layout.debugDescription) ...")
          expect(_ = try AlertLayout(layout: layout)).to(throwError())
        }
      }

      it("accepts title and message") {
        let layout = "title:message"
        let expected = AlertLayout(title: "title", message: "message", actions: [.fallback])
        var result: AlertLayout?
        expect { result = try AlertLayout(layout: layout) } .toNot(throwError())
        expect(result) == expected
      }

      it("accepts title and message and actions") {
        let layout = "title:message->act1|act2|act3"
        let expected = AlertLayout(title: "title", message: "message", actions: [
          AlertLayoutAction(title: "act1"),
          AlertLayoutAction(title: "act2"),
          AlertLayoutAction(title: "act3"),
        ])
        var result: AlertLayout?
        expect { result = try AlertLayout(layout: layout) } .toNot(throwError())
        expect(result) == expected
      }

      it("accepts multi-line format string") {

        let layout = """
          title:message
          ->act1|act2[c]|act3[d]
          """
        let expected = AlertLayout(title: "title", message: "message", actions: [
          AlertLayoutAction(title: "act1"),
          AlertLayoutAction(title: "act2", style: .cancel),
          AlertLayoutAction(title: "act3", style: .destructive),
        ])
        var result: AlertLayout?
        expect { result = try AlertLayout(layout: layout) } .toNot(throwError())
        expect(result) == expected
      }

    } // describe("AlertLayout")

  }
}

