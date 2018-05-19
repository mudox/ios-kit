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

extension MBPProxy where Base: UIView {

  public func execute(_ command: MBPCommand) {
    command.execute(base)
  }

  public var hud: Binder<MBPCommand> {
    return Binder(base) { base, command in
      command.execute(base)
    }
  }

}

