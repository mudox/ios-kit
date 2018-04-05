//
//  MBP.swift
//  MudoxKit
//
//  Created by Mudox on 14/08/2017.
//
//

import UIKit
import MBProgressHUD

import RxSwift
import RxCocoa

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .debug)

public typealias ChangeMBProgressHUD = (MBProgressHUD) -> ()

extension MBPProxy where Base: UIView {

  /// The base method of public methods __show(...)___ and __blink(...)___
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
  ///   - interval: Interval to hide the HUD after shown (defaults to nil, that
  ///     is keep visible).
  ///   - extraChanges: Additional configuration goes here.
  /// - Returns: MBPCommand.
  func show(
    title: String? = nil,
    message: String? = nil,
    progress: Double? = nil,
    mode: MBProgressHUDMode? = nil,
    hideIn interval: TimeInterval? = nil,
    extraChanges change: ChangeMBProgressHUD? = nil
  ) {
    // make sure HUD exisits & shown
    let hud = MBProgressHUD(for: base)
      ?? MBProgressHUD.showAdded(to: base, animated: true)

    hud.label.text = title
    hud.detailsLabel.text = message

    if let progress = progress {
      hud.progress = Float(progress)
    }

    if let mode = mode {
      hud.mode = mode
    }

    if var interval = interval {
      if interval < 0.5 {
        debugFailure("hide too quickly, increase to 0.5s")
        interval = 0.5
      }
      hud.hide(animated: true, afterDelay: interval)
    }

    change?(hud)
  }


  /// Combination of __show(...)__ and __hide(...)__
  ///
  /// - Parameters:
  ///   - interval: Title label text.
  ///   - title: Details label text.
  ///   - message: Progress (0.0 ~ 1.0), turn mode to __.determinate__ if was __.text__ mode before.
  ///   - progress: Display duration.
  ///   - extraConfigration: Addtional configuration code goes here.
  public func blink(
    for interval: TimeInterval = 1,
    title: String? = nil,
    message: String? = nil,
    progress: Double? = nil,
    mode: MBProgressHUDMode? = nil,
    extraChanges change: ChangeMBProgressHUD? = nil
  ) {
    show(
      title: title,
      message: message,
      progress: progress,
      mode: mode,
      hideIn: interval,
      extraChanges: change
    )
  }

  /// Update part of the HUD view's attributes after HUD view is shown.
  ///
  /// - Parameter config: Configuration block.
  func apply(_ change: ChangeMBProgressHUD) {
    if MBProgressHUD(for: base) == nil {
      jack.warn("HUD view does not exists")
    }
    
    let hud = MBProgressHUD(for: base)
      ?? MBProgressHUD.showAdded(to: base, animated: true)

    change(hud)
  }


  /// Hide the HUD immediately or after a delay
  ///
  /// - Parameter seconds: Delayed seconds, defautls to 0 (hide immediately)
  public func hide(in interval: TimeInterval = 0) {
    guard let hud = MBProgressHUD(for: base) else {
      jack.warn("HUD view does not exists")
      return
    }

    if interval == 0 {
      hud.hide(animated: true)
    } else {
      hud.hide(animated: true, afterDelay: interval)
    }
  }

  public var hud: Binder<MBPCommand> {
    return Binder(base) { base, command in
      switch command {

      case let .internalShow(title, message, progress, mode, changes):
        base.mbp.show(
          title: title,
          message: message,
          progress: progress,
          mode: mode,
          hideIn: nil,
          extraChanges: changes
        )

      case let .internalBlink(interval, title, message, progress, mode, changes):
        base.mbp.blink(
          for: interval,
          title: title,
          message: message,
          progress: progress,
          mode: mode,
          extraChanges: changes
        )

      case let .apply(change):
        base.mbp.apply(change)

      case .hide:
        base.mbp.hide()

      case let .hideIn(interval):
        base.mbp.hide(in: interval)

      }

    }
  }

}

