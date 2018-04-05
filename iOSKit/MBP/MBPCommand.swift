//
//  MBPCommand.swift
//  CocoaLumberjack
//
//  Created by Mudox on 2018/4/5.
//

import Foundation
import MBProgressHUD

private class Framework { } // for retrieving the framework bundle

var mbpBundle: Bundle = {
  let frameworkBundle = Bundle(for: Framework.self)
  let assetsBundleURL = frameworkBundle.url(forResource: "Assets", withExtension: "bundle")!
  return Bundle(url: assetsBundleURL)!
}()

public enum MBPCommand {

  case apply(ChangeMBProgressHUD)
  case hide
  case hideIn(TimeInterval)

  // private cases

  case internalShow(
    title: String?,
    message: String?,
    progress: Double?,
    mode: MBProgressHUDMode?,
    extraChanges: ChangeMBProgressHUD?
  )
  case internalBlink(
    for: TimeInterval,
    title: String?,
    message: String?,
    progress: Double?,
    mode: MBProgressHUDMode?,
    extraChanges: ChangeMBProgressHUD?
  )


  /// Configure and show HUD view.
  ///
  /// - Note: Use static func here instead of enum case to provide flexible
  ///   interface / (allow omitting arguments when call)
  ///
  /// - Important: Paramter settings override closure settings.
  ///
  /// - Parameters:
  ///   - title: Title string.
  ///   - message: Message string.
  ///   - progress: Progress number (0.0 ~ 1.0). If given a non-nil value and
  ///     the mode is __.text__, change the mode
  ///     to __.determinate__ automatically to a pie indicator.
  ///   - mode: HUD layout mode.
  ///   - extraChanges: Additional configuration goes here.
  /// - Returns: MBPCommand.
  public static func show(
    title: String? = nil,
    message: String? = nil,
    progress: Double? = nil,
    mode: MBProgressHUDMode? = nil,
    extraChanges: ChangeMBProgressHUD? = nil
  ) -> MBPCommand {
    return .internalShow(
      title: title,
      message: message,
      progress: progress,
      mode: mode,
      extraChanges: extraChanges
    )
  }


  /// Configure and show HUD view for a interval (defaults to 1s) then hide.
  ///
  /// - Note: Use static func here instead of enum case to provide flexible
  ///   interface / (allow omitting arguments when call)
  ///
  /// - Important: Paramter settings override closure settings.
  ///
  /// - Parameters:
  ///   - title: Title string.
  ///   - message: Message string.
  ///   - progress: Progress number (0.0 ~ 1.0). If given a non-nil value and
  ///     the mode is __.text__, change the mode
  ///     to __.determinate__ automatically to a pie indicator.
  ///   - mode: HUD layout mode.
  ///   - interval: Interval to hide the HUD after shown (defaults to 1s).
  ///   - extraChanges: Additional configuration goes here.
  /// - Returns: MBPCommand.
  public static func blink(
    for interval: TimeInterval = 1,
    title: String? = nil,
    message: String? = nil,
    progress: Double? = nil,
    mode: MBProgressHUDMode? = nil,
    extraChanges: ChangeMBProgressHUD? = nil
  ) -> MBPCommand {
    return .internalBlink(
      for: interval,
      title: title,
      message: message,
      progress: progress,
      mode: mode,
      extraChanges: extraChanges
    )
  }


  public static func update(title: String? = nil, message: String? = nil, progress: Double? = nil) -> MBPCommand {
    return .apply { hud in

      if let title = title {
        hud.label.text = title
      }

      if let message = message {
        hud.detailsLabel.text = message
      }

      if let progress = progress {
        hud.progress = Float(progress)
        if hud.mode == .text {
          hud.mode = .determinate
        }
      }

    }
  }


  public static func success(title: String? = nil, message: String? = nil) -> MBPCommand {
    return .blink(
      for: 1,
      title: (title == nil && message == nil) ? "Succeeded" : title,
      message: message,
      progress: nil,
      mode: .customView)
    { hud in
      // custom view
      let image = UIImage(named: "Check37", in: mbpBundle, compatibleWith: nil)
      let imageView = UIImageView(image: image)
      hud.customView = imageView
      
      hud.setForegroundColor(.white)
      hud.setBackgroundColor(UIColor(red: 0.205, green: 0.450, blue: 0.142, alpha: 1))

    }
  }


  public static func failure(title: String? = nil, message: String? = nil) -> MBPCommand {
    return .blink(
      for: 1,
      title: (title == nil && message == nil) ? "Failed" : title,
      message: message,
      progress: nil,
      mode: .customView)
    { hud in
      // custom view
      let image = UIImage(named: "Cross37", in: mbpBundle, compatibleWith: nil)
      let imageView = UIImageView(image: image)
      hud.customView = imageView
      
      hud.setForegroundColor(.white)
      hud.setBackgroundColor(UIColor(red: 0.800, green: 0.078, blue: 0.034, alpha: 1))
    }
  }
}
