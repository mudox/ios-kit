//
//  iOSKit_ExampleTests.swift
//  iOSKit_ExampleTests
//
//  Created by Mudox on 01/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import iOSKit

class iOSKit_ExampleTests: XCTestCase {

  func test_the() {
    XCTAssert(The.app == UIApplication.shared)
    XCTAssert(The.device == UIDevice.current)
    XCTAssert(The.fileManager == FileManager.default)
    XCTAssert(The.mainBundle == Bundle.main)
    XCTAssert(The.mainScreen == UIScreen.main)
    XCTAssert(The.mainWindow == UIApplication.shared.windows.first!)
    XCTAssert(The.notificationCenter == NotificationCenter.default)
    XCTAssert(The.userDefaults == UserDefaults.standard)
  }

  func test_uiApplication() {
    #if (arch(i386) || arch(x86_64)) && os(iOS)
      XCTAssert(The.app.mdx.isRunningOnSimulator == true)
    #else
      XCTAssert(The.app.mdx.isRunningOnSimulator == false)
    #endif

    #if DEBUG
      XCTAssert(The.app.mdx.isRunningInDebugMode == true)
    #else
      XCTAssert(The.app.mdx.isRunningInDebugMode == false)
    #endif
  }

  func test_alertController_parseSpec() {
    let inputAndOutputs: [String: (title: String?, message: String?, buttonTitle: [String])?] = [
      "title only": (title: "title only", message: nil, buttonTitle: ["OK"]),
      ":message only": (title: nil, message: "message only", buttonTitle: ["OK"]),
      "->button title only": nil,
      "title->button title": (title: "title", message: nil, buttonTitle: ["button title"]),
      ":message->button title": (title: nil, message: "message", buttonTitle: ["button title"]),
      ":2 buttons->button1|button2": (title: nil, message: "2 buttons", buttonTitle: ["button1", "button2"]),
      "3 buttons->button1|button2|button3": (title: "3 buttons", message: nil, buttonTitle: ["button1", "button2", "button3"]),
    ]

    for (input, output) in inputAndOutputs {
      print(">> input: \(input)")
      if output == nil {
        XCTAssert(UIAlertController.mdx.parsePattern(input) == nil)
      } else {
        let result = UIAlertController.mdx.parsePattern(input)!
        XCTAssert(result.title == output!.title)
        XCTAssert(result.message == output!.message)
        XCTAssert(result.buttonTitle == output!.buttonTitle)
      }
    }

  }

}
