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
    let inputAndOutputs: [String: (title: String?, message: String?, actions: [String])?] = [
      "title only": (title: "title only", message: nil, actions: ["OK"]),
      ":message only": (title: nil, message: "message only", actions: ["OK"]),
      "->action title only": nil,
      "title->action title": (title: "title", message: nil, actions: ["action title"]),
      ":message->action title": (title: nil, message: "message", actions: ["action title"]),
      ":2 actions->action1|action2": (title: nil, message: "2 actions", actions: ["action1", "action2"]),
      "3 actions->action1|action2|action3": (title: "3 actions", message: nil, actions: ["action1", "action2", "action3"]),
    ]

    for (input, output) in inputAndOutputs {
      print(">> input: \(input)")
      let result = UIAlertController.mdx.parse(layout: input)
      
      if output == nil {
        XCTAssert(result == nil)
      } else {
        let r = result!
        XCTAssert(!r.actions.isEmpty)
        XCTAssert(r.title == output!.title)
        XCTAssert(r.message == output!.message)
        XCTAssert(r.actions == output!.actions)
      }
    }

  }

}
