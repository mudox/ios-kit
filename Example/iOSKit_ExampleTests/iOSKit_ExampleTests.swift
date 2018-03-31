//
//  iOSKit_ExampleTests.swift
//  iOSKit_ExampleTests
//
//  Created by Mudox on 01/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import iOSKit


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

}
