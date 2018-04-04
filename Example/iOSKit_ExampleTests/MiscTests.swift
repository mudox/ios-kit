//
//  iOSKit_ExampleTests.swift
//  iOSKit_ExampleTests
//
//  Created by Mudox on 01/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Nimble

@testable import iOSKit

class MiscTests: XCTestCase {

  func test_the() {
    expect(The.app) == UIApplication.shared
    expect(The.device) == UIDevice.current
    expect(The.fileManager) == FileManager.default
    expect(The.mainBundle) == Bundle.main
    expect(The.mainScreen) == UIScreen.main
    expect(The.mainWindow) == UIApplication.shared.windows.first!
    expect(The.notificationCenter) == NotificationCenter.default
    expect(The.userDefaults) == UserDefaults.standard
  }

  func test_uiApplication() {
    #if targetEnvironment(simulator)
      expect(The.app.mdx.isRunningOnSimulator) == true
    #else
      expect(The.app.mdx.isRunningOnSimulator) == false
    #endif

    #if DEBUG
      expect(The.app.mdx.isRunningInDebugMode) == true
    #else
      expect(The.app.mdx.isRunningInDebugMode) == false
    #endif
  }

}
