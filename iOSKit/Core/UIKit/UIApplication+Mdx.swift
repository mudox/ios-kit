import UIKit

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .verbose)

extension Mudoxive where Base: UIApplication {

  public func openSettingsApp() {
    if #available(iOS 10.0, *) {
      UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
    } else {
      UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
    }
  }

  public var isInDebugMode: Bool {
    #if DEBUG
      return true
    #else
      return false
    #endif
  }

  public var isInSimulator: Bool {
    #if targetEnvironment(simulator)
      return true
    #else
      return false
    #endif
  }

  /**
   Log a line when App state transition happens.
   */
  public func tracksAppStates() {
    _appStates.forEach { item in
      The.notificationCenter.addObserver(forName: item.key, object: nil, queue: nil, using: { _ in
        jack.debug(item.value, from: .custom("App state observer"))
      })
    }
  }

  public func dumpInfo() {
    let lines = """
      [App]
        - Name       :   \(Info.appName)
        - ID         :   \(Info.appBundleID ?? "N/A")
        - Release    :   \(Info.appRelease ?? "N/A")  (CFBundleShortVersionString)
        - Build      :   \(Info.appBuild ?? "N/A") (kCFBundleVersionKey)
        - Debug      :   \(Info.isDebug)
        - Simulator  :   \(Info.isSimulator)
      [Device]
        - Name       :   \(Info.deviceName)
        - Model      :   \(Info.deviceModel)
        - UUID       :   \(Info.deviceUUID ?? "N/A")
      [System]
        - Name       :   \(Info.systemName)
        - Version    :   \(Info.systemVersion)
      """
    jack.info(lines, from: .custom("App \(Info.appName) Launched"))
  }
}
