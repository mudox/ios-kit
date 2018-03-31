//
//  MBP.swift
//  MudoxKit
//
//  Created by Mudox on 14/08/2017.
//
//

import UIKit
import MBProgressHUD
import JacKit

fileprivate let jack = Jack.with(levelOfThisFile: .debug)

public struct MBPProxy {
  public let baseView: UIView

  public init(_ baseView: UIView) {
    self.baseView = baseView
  }
}

extension UIView {
  public var mbp: MBPProxy {
    return MBPProxy(self)
  }
}

extension MBPProxy {

  /// Returns the base view's HUD if there is one
  public var hud: MBProgressHUD? {
    return MBProgressHUD(for: baseView)
  }

  /**
   Create (if not), show and set a HUD view

   - parameter mode:     Determines HUD appearance
   - parameter title:    Title label text
   - parameter message:  Details label text
   - parameter progress: Progress object which will be KVO'ed by HUD for progress trakcing on assignment
   */
  public func show(
    withMode mode: MBProgressHUDMode = .text,
    title: String,
    message: String? = nil,
    progress: Double? = nil
  ) {
    let hud = MBProgressHUD(for: baseView) ?? MBProgressHUD.showAdded(to: baseView, animated: true)

    // mode must not be .text if a progress object is given
    if progress != nil && mode == .text {
      hud.mode = .determinate
    } else {
      hud.mode = mode
    }
    hud.progress = Float(progress ?? 0)

    hud.label.text = title
    hud.detailsLabel.text = message
    hud.show(animated: true)
  }

  /**
   Hide the HUD immediately or after a delay

   - parameter seconds: Delayed seconds
   */
  public func hide(in seconds: TimeInterval = 0) {
    guard let hud = MBProgressHUD(for: baseView) else {
      jack.verbose("no HUD view is found, maybe it is already hidden by previous `mpb.blink(...)` call")
      return
    }

    if seconds == 0 {
      hud.hide(animated: true)
    } else {
      hud.hide(animated: true, afterDelay: seconds)
    }
  }

  /**
   A combination of show(...) and hide(in: defaults to 1 seconds)

   - parameter mode:     Determines HUD appearance
   - parameter title:    Title label text
   - parameter message:  Details label text
   - parameter progress: Progress object which will be KVO'ed by HUD for progress trakcing on assignment
   - parameter seconds:  Display duration
   */
  public func blink(
    withMode mode: MBProgressHUDMode = .text,
    title: String,
    message: String? = nil,
    progress: Double? = nil,
    for seconds: TimeInterval = 1
  ) {
    show(withMode: mode, title: title, message: message, progress: progress)
    hide(in: seconds)
  }
}

