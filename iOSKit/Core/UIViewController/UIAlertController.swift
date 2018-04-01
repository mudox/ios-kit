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
  case parseFailure
  case noRootViewController
}

extension Mudoxive where Base: UIAlertController {

  public static func parse(layout: String) -> (
    title: String?,
    message: String?,
    buttonTitle: [String]
  )?
  {
    let titlePattern = "([^:]+?)"
    let messagePattern = "(?::([^:]+?))"
    let buttonPattern = "(?:->([^|]+(?:\\|([^|].+))?))"
    let regexString = "^\(titlePattern)?\(messagePattern)?\(buttonPattern)?$"
    do {
      let regex = try NSRegularExpression(pattern: regexString, options: [])
      let matchOrNil = regex.firstMatch(in: layout, options: [], range: NSRange(location: 0, length: layout.count))
      guard let match = matchOrNil else {
        return nil
      }

      // title
      var title: String?
      var range = match.range(at: 1)
      if range.location == NSNotFound {
        title = nil
      } else {
        title = (layout as NSString).substring(with: range)
      }

      // message
      var message: String?
      range = match.range(at: 2)
      if range.location == NSNotFound {
        message = nil
      } else {
        message = (layout as NSString).substring(with: range)
      }

      // button title(s)
      var buttonTitles: [String]
      range = match.range(at: 3)
      if range.location == NSNotFound {
        buttonTitles = ["OK"]
      } else {
        let group = (layout as NSString).substring(with: range)
        buttonTitles = (group as String).split(separator: "|").map { String($0) }
      }

      if title != nil && title!.starts(with: "->") {
        jack.error("Must provide either title or message")
        return nil
      }

      if (title == nil && message == nil) {
        jack.error("Must provide either title or message")
        return nil
      }

      return (title: title, message: message, buttonTitle: buttonTitles)
    } catch {
      jack.error("Failed to initialize regex: \(error)")
      return nil
    }
  }

  public static func simpleAlert(layout: String) -> Completable {
    guard let (title, message, buttonTitles) = parse(layout: layout) else {
      return Completable.error(UIAlertControllerError.parseFailure)
    }

    return Completable.create { completable in
      // construct alert controller
      let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
      let action = UIAlertAction(title: buttonTitles.first!, style: .default) { _ in
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

}
