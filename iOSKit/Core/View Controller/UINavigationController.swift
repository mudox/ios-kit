//
//  UINavigationController.swift
//  iOSKit
//
//  Created by Mudox on 01/04/2018.
//

import UIKit

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .debug)

public class InteractivePopNavigationController: UINavigationController {

  public enum InteractivePopStyle {
    case none
    case inherit
    case edge
    case anywhere
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    if _popTransitionController == nil {
      _popTransitionController = interactivePopGestureRecognizer?.delegate
    }

    if _panAnywhereToPop == nil {
      _panAnywhereToPop = UIPanGestureRecognizer(
        target: _popTransitionController,
        action: Selector(("handleNavigationTransition:"))
      )
      _panAnywhereToPop!.delegate = self
      _panAnywhereToPop?.isEnabled = false
      view.addGestureRecognizer(_panAnywhereToPop!)
    }
  }

  private var _panAnywhereToPop: UIPanGestureRecognizer!

  private var _popTransitionController: UIGestureRecognizerDelegate!


  public var interactivePopStyle: InteractivePopStyle = .inherit {
    willSet {
      if (interactivePopStyle == newValue) {
        return
      }

      // reset settings
      interactivePopGestureRecognizer?.isEnabled = true
      interactivePopGestureRecognizer?.delegate = _popTransitionController
      _panAnywhereToPop.isEnabled = false

      switch newValue {
      case .none:
        interactivePopGestureRecognizer?.isEnabled = false
      case .inherit:
        // already reset above
        break
      case .edge:
        interactivePopGestureRecognizer?.delegate = self
      case .anywhere:
        interactivePopGestureRecognizer?.isEnabled = false
        _panAnywhereToPop.isEnabled = true
      }

    }
  }

}

extension InteractivePopNavigationController: UIGestureRecognizerDelegate {
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    let moreThanOneContentViewControllers = viewControllers.count > 1

    if (gestureRecognizer == _panAnywhereToPop) {
      let isPaningToRight = _panAnywhereToPop.translation(in: view).x > 0
      return isPaningToRight && moreThanOneContentViewControllers
    } else {
      return moreThanOneContentViewControllers
    }
  }
}

