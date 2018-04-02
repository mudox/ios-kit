//
//  UIAlertController.swift
//  iOSKit
//
//  Created by Mudox on 01/04/2018.
//

import UIKit
import RxSwift

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .debug)

public enum UIAlertControllerError: Error {
  case layoutParseFailure
  case noRootViewController
}

extension Mudoxive where Base: UIAlertController {
  
  /// Present a simple alert with only one confirm button using the root view controller.
  ///
  ///
  /// - Parameter layout: layout string.
  /// - Returns: RxSwift.Completable
  public static func simpleAlert(layout: String) -> Completable {
    var result: AlertLayout
    do {
      result = try AlertLayout(layout: layout)
    } catch {
      return Completable.error(error)
    }
    
    let title = result.title
    let message = result.message
    let actions = result.actions

    return Completable.create { completable in
      // construct alert controller
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let action = UIAlertAction(title: actions.first!.title, style: .default) { _ in
        completable(.completed)
      }
      alert.addAction(action)

      // present by root view controller
      guard let viewController = The.mainWindow.rootViewController else {
        completable(.error(UIAlertControllerError.noRootViewController))
        return Disposables.create()
      }
      viewController.present(alert, animated: true, completion: nil)

      // in case of mannually disposal
      // e.g UIAlertController.mdx.simpleAlert(...).take(2, scheduler: MainScheduler.instance)
      return Disposables.create { [weak alert] in
        alert?.dismiss(animated: false, completion: nil)
      }
    }
  }

  public static func actionSheet(layout: String) -> Single<String> {
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
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      actions.forEach { action in
        alert.addAction(UIAlertAction(title: action.title, style: action.style, handler: { _ in
          single(.success(action.title))
        }))
      }

      // present by root view controller
      guard let viewController = The.mainWindow.rootViewController else {
        single(.error(UIAlertControllerError.noRootViewController))
        return Disposables.create()
      }
      viewController.present(alert, animated: true, completion: nil)

      return Disposables.create()
    }
  }
}
