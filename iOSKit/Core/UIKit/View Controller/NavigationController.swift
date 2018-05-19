import UIKit

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .verbose)

open class NavigationController: UINavigationController {

  public enum popStyle {
    case none
    case inherit
    case edge
    case anywhere
  }

  fileprivate var _panAnywhereToPop: UIPanGestureRecognizer!
  fileprivate var _popTransitionController: UIGestureRecognizerDelegate!

  open override func viewDidLoad() {

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

  public var interactivePopStyle: popStyle = .inherit {
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

extension InteractivePopNavigationController.InteractivePopStyle: CustomStringConvertible {

  public var description: String {
    switch self {
    case .none: return "InteractivePopNavigationController.InteractivePopStyle.none"
    case .inherit: return "InteractivePopNavigationController.InteractivePopStyle.inherit"
    case .edge: return "InteractivePopNavigationController.InteractivePopStyle.edge"
    case .anywhere: return "InteractivePopNavigationController.InteractivePopStyle.anywhere"
    }
  }

}
