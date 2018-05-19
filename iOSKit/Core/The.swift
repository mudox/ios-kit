//
//  File.swift
//  iOSKit
//
//  Created by Mudox on 21/11/2017.
//

import UIKit

/// The special `enum` used as namespace for all commonly accessed
/// global symbols
public enum The {

  /// UIApplication.shared
  public static var app: UIApplication {
    return UIApplication.shared
  }
  /// UIDevice.current
  public static var device: UIDevice {
    return UIDevice.current
  }

  /// FileManager.default
  public static var fileManager: FileManager {
    return FileManager.default
  }

  /// Bundle.main
  public static var mainBundle: Bundle {
    return Bundle.main
  }

  /// UIScreen.main
  public static var mainScreen: UIScreen {
    return UIScreen.main
  }

  /// UIApplication.shared.windows.first!
  public static var mainWindow: UIWindow {
    return The.app.windows.first!
  }

  /// UIApplication.shared.windows.first!.rootViewController
  public static var rootViewController: UIViewController? {
    return The.mainWindow.rootViewController
  }

  /// NofiticationCenter.default
  public static var notificationCenter: NotificationCenter {
    return NotificationCenter.default
  }

  /// ProcessInfo.processInfo
  public static var processInfo: ProcessInfo {
    return ProcessInfo.processInfo
  }

  /// UserDefaults.standard
  public static var userDefaults: UserDefaults {
    return UserDefaults.standard
  }

}
