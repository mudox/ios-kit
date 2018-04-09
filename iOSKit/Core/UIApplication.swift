//
//  UIDevice.swift
//  CocoaLumberjack
//
//  Created by Mudox on 01/04/2018.
//

import UIKit

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .verbose)

private let _appStates: [Notification.Name: String] = [
  // launching state
  .UIApplicationDidFinishLaunching: "App did finish launching",

  // active state
  .UIApplicationDidBecomeActive: "App did become active",
    .UIApplicationWillResignActive: "App will resign active",

  // background state
  .UIApplicationDidEnterBackground: "App did enter background",
    .UIApplicationWillEnterForeground: "App will enter foreground",

  // terminat state
  .UIApplicationWillTerminate: "App will terminate",

  // memory warning
  .UIApplicationDidReceiveMemoryWarning: "App did receive memory warning",

  // significant time changing
  .UIApplicationSignificantTimeChange: "App siginificant time change",

  // status bar
  .UIApplicationWillChangeStatusBarOrientation: "App will change status bar orientation",
    .UIApplicationDidChangeStatusBarOrientation: "App did change status bar orientation",
    .UIApplicationWillChangeStatusBarFrame: "App will change status bar frame",
    .UIApplicationDidChangeStatusBarFrame: "App did change status bar frame",

  // background refresh
  .UIApplicationBackgroundRefreshStatusDidChange: "App did change background refresh status",

  // protected data
  .UIApplicationProtectedDataWillBecomeUnavailable: "App prototected data will become unavailable",
    .UIApplicationProtectedDataDidBecomeAvailable: "App protected data did become available",
]


extension Mudoxive where Base: UIApplication {

  public var isRunningInDebugMode: Bool {
    #if DEBUG
      return true
    #else
      return false
    #endif
  }

  public var isRunningOnSimulator: Bool {
    #if targetEnvironment(simulator)
      return true
    #else
      return false
    #endif
  }

  public func greet() {
    fatalError("Unimplemented")
  }

  /**
   Log a line when App state transition happens.
   */
  public func observeAppStates() {
    _appStates.forEach { item in
      The.notificationCenter.addObserver(forName: item.key, object: nil, queue: nil, using: { _ in
        jack.debug(item.value, from: .custom("App state observer"))
      })
    }
  }

  public func dumpInfo() {
    let lines = """
      [App]
        - Name:              \(The.processInfo.processName)
        - ID:                \(The.mainBundle.bundleIdentifier ?? "N/A")
        - Release:           \(The.mainBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "N/A")  (CFBundleShortVersionString)
        - Build:             \(The.mainBundle.object(forInfoDictionaryKey: kCFBundleVersionKey as String) ?? "N/A") (kCFBundleVersionKey)
        - Debug:             \(The.app.mdx.isRunningInDebugMode)
        - Simulator:         \(The.app.mdx.isRunningOnSimulator)
      [Device]
        - Name:              \(The.device.name)
        - Model:             \(The.device.localizedModel)
        - UUID:              \(The.device.identifierForVendor!.uuidString)
      [System]
        - Name:              \(The.device.systemName)
        - Version:           \(The.device.systemVersion)
    """
    jack.info(lines, from: .custom("App info"))
  }
}
