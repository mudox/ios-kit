//
//  MBPCommand.swift
//  CocoaLumberjack
//
//  Created by Mudox on 2018/4/5.
//

import Foundation
import MBProgressHUD

import JacKit
fileprivate let jack = Jack.with(fileLocalLevel: .verbose)

/// Change MBProgressHUD view
public typealias ChangeMBP = (MBProgressHUD) -> ()

/// Change MBProgressHUD view for the parameter view
public typealias ChangeMBPofView = (UIView) -> ()

public struct MBPCommand {

  let change: ChangeMBPofView

  func execute(_ view: UIView) {
    change(view)
  }

  private init(change: @escaping ChangeMBPofView) {
    self.change = change
  }

  public static func start(
    title: String? = nil,
    message: String? = nil,
    mode: MBProgressHUDMode = .indeterminate,
    extra change: ChangeMBP? = nil
  ) -> MBPCommand {
    return MBPCommand.init { view in
      // make sure hud is shown
      let hud = MBProgressHUD(for: view) ?? MBProgressHUD.showAdded(to: view, animated: true)

      // texts
      hud.label.text = title
      hud.detailsLabel.text = message

      // progress and mode
      hud.progress = 0
      hud.mode = mode

      // apply extra change if any
      change?(hud)
    }
  }

  public static func update(progress: Double, extra change: ChangeMBP? = nil) -> MBPCommand {
    return MBPCommand.init { view in
      // make sure hud is shown
      let hud = MBProgressHUD(for: view) ?? MBProgressHUD.showAdded(to: view, animated: true)
      hud.progress = Float(progress)

      // apply extra change if any
      change?(hud)
    }
  }

  public static func nextStep(
    title: String? = nil,
    message: String? = nil,
    progress: Double? = nil,
    mode: MBProgressHUDMode = .indeterminate,
    extra change: ChangeMBP? = nil
  ) -> MBPCommand {
    return MBPCommand.init { view in
      // make sure hud is shown
      let hud = MBProgressHUD(for: view) ?? MBProgressHUD.showAdded(to: view, animated: true)

      // texts
      hud.label.text = title
      hud.detailsLabel.text = message

      // progress and mode
      if let progress = progress {
        hud.progress = Float(progress)
      }
      hud.mode = mode

      // apply extra change if any
      change?(hud)
    }
  }

  /// Predefined appearance for success result.
  ///
  /// - Parameters:
  ///   - title: Title string.
  ///   - message: Message String.
  ///   - interval: Interval in which to hide the HUD.
  ///   - change: Extra modifications applied to the HUD.
  /// - Returns: The MBPCommand to change the HUD states.
  public static func success(
    title: String? = nil,
    message: String? = nil,
    hideIn interval: TimeInterval = 1,
    extra change: ChangeMBP? = nil
  ) -> MBPCommand {
    return MBPCommand.init { view in
      // make sure hud is shown
      let hud = MBProgressHUD(for: view) ?? MBProgressHUD.showAdded(to: view, animated: true)

      // progress and mode
      hud.progress = 0
      hud.mode = .customView

      // custom view to show success mark
      let image = UIImage.checkMark
      let imageView = UIImageView(image: image)
      hud.customView = imageView

      // text
      hud.label.text = title
      hud.detailsLabel.text = message

      // color
      hud.setForeground(color: .white)
      hud.setBackground(color: .success)


      // apply extra change if any
      change?(hud)

      // hide
      hud.hide(animated: true, afterDelay: interval)
    }
  }

  /// Predefined appearance for failure result.
  ///
  /// - Parameters:
  ///   - title: Title string.
  ///   - message: Message String.
  ///   - interval: Interval in which to hide the HUD.
  ///   - change: Extra modifications applied to the HUD.
  /// - Returns: The MBPCommand to change the HUD states.
  public static func failure(title: String? = nil, message: String? = nil, hideIn interval: TimeInterval = 1, extra change: ChangeMBP? = nil) -> MBPCommand {
    return MBPCommand.init { view in
      // make sure hud is shown
      let hud = MBProgressHUD(for: view) ?? MBProgressHUD.showAdded(to: view, animated: true)

      // progress and mode
      hud.progress = 0
      hud.mode = .customView

      // custom view to show success mark
      let image = UIImage.crossMark
      let imageView = UIImageView(image: image)
      hud.customView = imageView

      // text
      hud.label.text = title
      hud.detailsLabel.text = message

      // color
      hud.setForeground(color: .white)
      hud.setBackground(color: .failure)


      // apply extra change if any
      change?(hud)

      // hide
      hud.hide(animated: true, afterDelay: interval)
    }
  }
}
