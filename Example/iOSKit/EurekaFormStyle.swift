//
//  EurekaFormStyle.swift
//  iOSKit_Example
//
//  Created by Mudox on 2018/4/6.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import Eureka

import iOSKit
import MBProgressHUD

private let fontSize: CGFloat = 17
private let fontColor: UIColor = #colorLiteral(red: 0.6039215686, green: 0.6039215686, blue: 0.6196078431, alpha: 1)

private func setLabel(_ label: UILabel) {
  label.font = UIFont.systemFont(ofSize: fontSize)
  label.textColor = fontColor
  label.adjustsFontSizeToFitWidth = true
  label.minimumScaleFactor = 0.7
}

private func setField(_ field: UITextField) {
  field.font = UIFont.systemFont(ofSize: fontSize)
  field.textColor = fontColor
  field.adjustsFontSizeToFitWidth = true
  field.minimumFontSize = 12
}


/// Call it in AppDelegate.appDidFinishLauching...
func setupEurekaFormStyle() {

  TextRow.defaultCellUpdate = { cell, row in
    setField(cell.textField!)
  }

  StepperRow.defaultCellUpdate = { cell, row in
    setLabel(cell.valueLabel!)
  }

  PushRow<MBProgressHUDMode>.defaultCellUpdate = { cell, row in
    setLabel(cell.detailTextLabel!)
  }

  PickerInlineRow<MBProgressHUDBackgroundStyle>.defaultCellUpdate = { cell, row in
    setLabel(cell.detailTextLabel!)
    setLabel(cell.textLabel!)
  }
}

