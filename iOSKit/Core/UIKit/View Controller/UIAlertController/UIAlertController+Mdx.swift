import UIKit
import RxSwift

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .verbose)

public enum UIAlertControllerError: Error {
  case layoutParseFailure
  case noRootViewController
}

extension Mudoxive where Base: UIAlertController {

  /// Present an alert controller with layout parsed from a layout string.
  ///
  /// - Parameters:
  ///   - layout: Layout string.
  ///   - style: Alert controller style. Either `.alert` or `.actionSheet`.
  ///   - sourceViewController: The view controller which presents
  ///     the the alert controller, when nil try using the root view controller.
  /// - Returns: Single<String> where the value is selected button's title.
  public static func present(
    layout: String,
    style: UIAlertControllerStyle,
    by sourceViewController: UIViewController? = nil
  ) -> Single<String>
  {
    var result: AlertLayout
    do {
      result = try AlertLayout(layout: layout)
    } catch {
      return Single.error(error)
    }

    let title = result.title
    let message = result.message
    let actions = result.actions

    return Single.create { single in
      // construct alert controller
      let alert = UIAlertController(title: title, message: message, preferredStyle: style)
      actions.forEach { action in
        alert.addAction(UIAlertAction(title: action.title, style: action.style, handler: { _ in
          single(.success(action.title))
        }))
      }

      guard let sourceViewController = sourceViewController ?? The.mainWindow.rootViewController else {
        single(.error(UIAlertControllerError.noRootViewController))
        return Disposables.create()
      }
      sourceViewController.present(alert, animated: true, completion: nil)

      return Disposables.create()
    }
  }

}
