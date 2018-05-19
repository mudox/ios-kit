import UIKit

public enum Info {
  // MARK: App
  public static var appName: String {
    return The.processInfo.processName
  }
  public static var appBundleID: String? {
    return The.mainBundle.bundleIdentifier
  }
  public static var appRelease: String? {
    return The.mainBundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
  }
  public static var appBuild: String? {
    return The.mainBundle.object(forInfoDictionaryKey: kCFBundleVersionKey as String) as? String
  }
  public static var isDebug: Bool {
    return The.app.mdx.isInDebugMode
  }
  public static var isSimulator: Bool {
    return The.app.mdx.isInSimulator
  }

  // MARK: Device
  public static var deviceName: String {
    return The.device.name
  }
  public static var deviceModel: String {
    return The.device.model
  }
  public static var deviceUUID: String? {
    return The.device.identifierForVendor?.uuidString
  }

  // MARK: System
  public static var systemName: String {
    return The.device.systemName
  }
  public static var systemVersion: String {
    return The.device.systemVersion
  }

  // MARK: Screen
  public static var screenWidth: CGFloat {
    return The.mainScreen.bounds.width
  }

  public static var screenHeight: CGFloat {
    return The.mainScreen.bounds.height
  }
}
