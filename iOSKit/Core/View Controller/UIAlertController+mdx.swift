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
  
  public static func present(layout: String, style: UIAlertControllerStyle) -> Single<String> {
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
