import UIKit

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .verbose)

let _appStates: [Notification.Name: String] = [
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
