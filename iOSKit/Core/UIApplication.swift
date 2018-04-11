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
  Notification.Name.UIApplicationDidFinishLaunching: "App did finish launching",

  // active state
  Notification.Name.UIApplicationDidBecomeActive: "App did become active",
  Notification.Name.UIApplicationWillResignActive: "App will resign active",

  // background state
  Notification.Name.UIApplicationDidEnterBackground: "App did enter background",
  Notification.Name.UIApplicationWillEnterForeground: "App will enter foreground",

  // terminat state
  Notification.Name.UIApplicationWillTerminate: "App will terminate",

  // memory warning
  Notification.Name.UIApplicationDidReceiveMemoryWarning: "App did receive memory warning",

  // significant time changing
  Notification.Name.UIApplicationSignificantTimeChange: "App siginificant time change",

  // status bar
  Notification.Name.UIApplicationWillChangeStatusBarOrientation: "App will change status bar orientation",
  Notification.Name.UIApplicationDidChangeStatusBarOrientation: "App did change status bar orientation",
  Notification.Name.UIApplicationWillChangeStatusBarFrame: "App will change status bar frame",
  Notification.Name.UIApplicationDidChangeStatusBarFrame: "App did change status bar frame",

  // background refresh
  Notification.Name.UIApplicationBackgroundRefreshStatusDidChange: "App did change background refresh status",

  // protected data
  Notification.Name.UIApplicationProtectedDataWillBecomeUnavailable: "App prototected data will become unavailable",
  Notification.Name.UIApplicationProtectedDataDidBecomeAvailable: "App protected data did become available",
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
        - Name       :   \(The.info.appName)
        - ID         :   \(The.info.bundleID ?? "N/A")
        - Release    :   \(The.info.appRelease ?? "N/A")  (CFBundleShortVersionString)
        - Build      :   \(The.info.appBuild ?? "N/A") (kCFBundleVersionKey)
        - Debug      :   \(The.info.isDebug)
        - Simulator  :   \(The.info.isSimulator)
      [Device]
        - Name       :   \(The.info.deviceName)
        - Model      :   \(The.info.deviceModel)
        - UUID       :   \(The.info.deviceUUID ?? "N/A")
      [System]
        - Name       :   \(The.info.systemName)
        - Version    :   \(The.info.systemVersion)
      """
    jack.info(lines, from: .custom("App \(The.info.appName) Launched"))
  }
}
