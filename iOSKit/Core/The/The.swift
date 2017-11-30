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

  /**
    UIApplication.shared.windows.first
    - important: Make sure the window is already created before access or
      the app would crash for nil unwrap
  */
  public static var mainWindow: UIWindow {
    return The.app.windows.first!
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

// MARK: - Project Specific Assets
extension The {
  
  /// The namespace to unique user defaults key names
  public enum UserDefaultsKey { }

}

// MARK: - Commonly Accessed Readonly Info

extension The {
  public enum Info {

    public static var appVersion: String! {
      return The.mainBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    }

    public static var appID: String! {
      return The.mainBundle.bundleIdentifier
    }

    public static var screenWidth: CGFloat {
      return The.mainScreen.bounds.width
    }

    public static var screenHeight: CGFloat {
      return The.mainScreen.bounds.height
    }

    public static var isRunningOnSimulator: Bool {
      return The.device.mdx_isSimulator
    }

    public static var isDebugModeEnabled: Bool {
      return The.app.mdx_isInDebugMode
    }

  }
}
