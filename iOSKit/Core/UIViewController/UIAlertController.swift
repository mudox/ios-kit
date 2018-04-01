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

  public static func parse(layout: String) -> (
    title: String?,
    message: String?,
    actions: [(title: String, style: UIAlertActionStyle)]
  )?
  {
    let titlePattern = "([^:]+?)"
    let messagePattern = "(?::([^:]+?))"
    let actionsPattern = "(?:->([^|]+(?:\\|([^|].+))?))"
    let regexString = "^\(titlePattern)?\(messagePattern)?\(actionsPattern)?$"
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

      // action title(s) and styles
      var actions: [(title: String, style: UIAlertActionStyle)]
      range = match.range(at: 3)
      if range.location == NSNotFound {
        actions = [("OK", .default)]
      } else {
        let group = (layout as NSString).substring(with: range)
        actions = group
          .split(separator: "|")
          .map { String($0) }
          .map { spec in
            if spec.hasSuffix("[c]") {
              return (String(spec.dropLast(3)), .cancel)
            } else if spec.hasSuffix("[d]") {
              return (String(spec.dropLast(3)), .destructive)
            } else {
              return (spec, .default)
            }
        }

      }

      if title != nil && title!.starts(with: "->") {
        jack.error("Must provide either title or message")
        return nil
      }

      if (title == nil && message == nil) {
        jack.error("Must provide either title or message")
        return nil
      }

      return (title: title, message: message, actions: actions)
    } catch {
      jack.error("Failed to initialize regex: \(error)")
      return nil
    }
  }

  public static func simpleAlert(layout: String) -> Completable {
    guard let (title, message, actions) = parse(layout: layout) else {
      return Completable.error(UIAlertControllerError.layoutParseFailure)
    }

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
    guard let (title, message, actions) = parse(layout: layout) else {
      return Single.error(UIAlertControllerError.layoutParseFailure)
    }

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
