//
//  AlertLayout.swift
//  iOSKit
//
//  Created by Mudox on 02/04/2018.
//

import UIKit

public struct AlertLayoutAction: Equatable {

  public static let fallback = AlertLayoutAction(title: "Dismiss")

  public let title: String
  public let style: UIAlertActionStyle

  init(title: String, style: UIAlertActionStyle = .default) {
    self.title = title
    self.style = style
  }

  public static func == (lhs: AlertLayoutAction, rhs: AlertLayoutAction) -> Bool {
    return lhs.title == rhs.title && lhs.style == rhs.style
  }

}


public struct AlertLayout {
  public let title: String?
  public let message: String?
  public let actions: [AlertLayoutAction]
}

extension AlertLayout {

  public enum Errors: Error {
    case regexMatch
    case needTitleOrMessage
    case invalidAction(String)
  }

  public init(layout: String) throws {
    if layout.hasPrefix("->") {
      throw Errors.needTitleOrMessage
    }

    let pattern = """
    ^
    # title
    \\s* ([^:(->)|]+?)?
    # message
    \\s* (?::([^:]+?))?
    # actions
    \\s* (?:->([^|]+(?:\\|([^|].+))?))? \\s*
    $
    """

    let regex = try NSRegularExpression(pattern: pattern, options: [.allowCommentsAndWhitespace])
    let matchOrNil = regex.firstMatch(in: layout, options: [], range: NSRange(location: 0, length: layout.count))
    guard let match = matchOrNil else {
      throw Errors.regexMatch
    }

    // title
    var title: String?
    var range = match.range(at: 1)
    if range.location == NSNotFound {
      title = nil
    } else {
      title = (layout as NSString).substring(with: range).trimmed()
    }

    // message
    var message: String?
    range = match.range(at: 2)
    if range.location == NSNotFound {
      message = nil
    } else {
      message = (layout as NSString).substring(with: range).trimmed()
    }

    // action title(s) and styles
    var actions: [AlertLayoutAction]
    let fallbackAction = AlertLayoutAction.fallback

    range = match.range(at: 3)
    if range.location == NSNotFound {
      actions = [fallbackAction]
    } else {
      let group = (layout as NSString).substring(with: range)
      actions = try group
        .split(separator: "|")
        .map {
          let spec = String($0).trimmed()
          if spec.hasSuffix("[c]") {
            let title = String(spec.dropLast(3))
            guard !title.isEmpty else {
              throw Errors.invalidAction(String(spec))
            }
            return AlertLayoutAction(title: title, style: .cancel)
          }
          if spec.hasSuffix("[d]") {
            let title = String(spec.dropLast(3))
            guard !title.isEmpty else {
              throw Errors.invalidAction(String(spec))
            }
            return AlertLayoutAction(title: title, style: .destructive)
          }
          return AlertLayoutAction(title: String(spec))
      }
      if actions.isEmpty {
        throw Errors.invalidAction(group)
      }
    }

    if (title == nil && message == nil) {
      throw Errors.needTitleOrMessage
    }

    if actions.isEmpty {
      actions = [.fallback]
    }

    self.init(title: title, message: message, actions: actions)
  }
}

extension AlertLayout: Equatable {
  public static func == (lhs: AlertLayout, rhs: AlertLayout) -> Bool {
    return lhs.title == rhs.title
      && lhs.message == rhs.message
      && lhs.actions == rhs.actions
  }
}

