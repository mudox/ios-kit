import XCTest
import Nimble

@testable import iOSKit

class AlertLayoutTests: XCTestCase {

  override func setUp() {
    super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    super.tearDown()
  }

  func test_empty() {
    let layout = ""
    expect { _ = try AlertLayout(layout: layout) } .to(throwError())
  }

  func test_onlyTitle() {
    let layout = "title"
    let expected = AlertLayout(title: "title", message: nil, actions: [.fallback])
    var result: AlertLayout?
    expect { result = try AlertLayout(layout: layout) } .toNot(throwError())
    expect(result) == expected
  }

  func test_onlyMessage() {
    let layout = ":message"
    let expected = AlertLayout(title: nil, message: "message", actions: [.fallback])
    var result: AlertLayout?
    expect { result = try AlertLayout(layout: layout) } .toNot(throwError())
    expect(result) == expected
  }

  func test_onlyActions() {
    let layout = "->action1|action2"
    expect { _ = try AlertLayout(layout: layout) }.to(throwError(AlertLayout.Errors.needTitleOrMessage))
  }

  func test_actionsWithoutTitle() {
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

  func test_titleAndMessage() {
    let layout = "title:message"
    let expected = AlertLayout(title: "title", message: "message", actions: [.fallback])
    var result: AlertLayout?
    expect { result = try AlertLayout(layout: layout) } .toNot(throwError())
    expect(result) == expected
  }

  func test_titleMessageAndActions() {
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

  func test_multilineLayout() {
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
}
