import XCTest
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

  func test_onlyTitle() {
    let layout = "title"
    let expect = AlertLayout(title: "title", message: nil, actions: [.fallback])
    var result: AlertLayout?
    XCTAssertNoThrow(result = try AlertLayout(layout: layout))
    XCTAssert(result == expect)
  }

  func test_onlyMessage() {
    let layout = ":message"
    let expect = AlertLayout(title: nil, message: "message", actions: [.fallback])
    var result: AlertLayout?
    XCTAssertNoThrow(result = try AlertLayout(layout: layout))
    XCTAssert(result == expect)
  }

  func test_onlyActions() {
    let layout = "->action1|action2"
    let message = "Should throw AlertLayout.Errors.needTitleOrMessage"
    XCTAssertThrowsError(try AlertLayout(layout: layout), message) { error in
      if case AlertLayout.Errors.needTitleOrMessage = error {
        XCTAssert(true)
      } else {
        XCTFail()
      }
    }
  }
  
  func test_actionsWithoutTitle() {
    let layouts = [
      "title->[c]",
      "title->act||",
      "title->act1|[d]|act2",
    ]
    try! layouts.forEach { layout in
      print("🎾 feed \(layout.debugDescription) ...")
      XCTAssertThrowsError(try AlertLayout(layout: layout))
    }
  }

  func test_titleAndMessage() {
    let layout = "title:message"
    let expect = AlertLayout(title: "title", message: "message", actions: [.fallback])
    var result: AlertLayout?
    XCTAssertNoThrow(result = try AlertLayout(layout: layout))
    XCTAssert(result == expect)
  }

  func test_titleMessageAndActions() {
    let layout = "title:message->act1|act2|act3"
    let expect = AlertLayout(title: "title", message: "message", actions: [
      AlertLayoutAction(title: "act1"),
      AlertLayoutAction(title: "act2"),
      AlertLayoutAction(title: "act3"),
    ])
    var result: AlertLayout?
    XCTAssertNoThrow(result = try AlertLayout(layout: layout))
    XCTAssert(result == expect)
  }
  
  func test_multilineLayout() {
    let layout = """
      title:message
      ->act1|act2[c]|act3[d]
    """
    let expect = AlertLayout(title: "title", message: "message", actions: [
      AlertLayoutAction(title: "act1"),
      AlertLayoutAction(title: "act2", style: .cancel),
      AlertLayoutAction(title: "act3", style: .destructive),
      ])
    var result: AlertLayout?
    XCTAssertNoThrow(result = try AlertLayout(layout: layout))
    XCTAssert(result == expect)
  }
}
