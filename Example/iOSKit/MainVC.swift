//
//  MainViewController.swift
//  iOSKit_Example
//
//  Created by Mudox on 01/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Eureka
import RxSwift
import RxCocoa

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .debug)

class MainVC: FormViewController {
  var disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    form +++ Section("View Controller Extensions")

    <<< ButtonRow() {
      $0.title = "UIAlertController Layout String"
      $0.presentationMode = .show(controllerProvider: .callback(builder: AlertVC.init), onDismiss: nil)
    }

    <<< ButtonRow() {
      $0.title = "Interactive Pop"
      $0.presentationMode = .show(controllerProvider: .callback(builder: NavPopVC.init), onDismiss: nil)
    }

    form +++ Section("HUD controls")

    <<< ButtonRow() {
      $0.title = "MBProgressHUD"
      $0.presentationMode = .show(controllerProvider: .callback(builder: MbpVC.init), onDismiss: nil)
    }

    <<< ButtonRow() {
      $0.title = "SVProgressHUD"
      $0.presentationMode = .show(controllerProvider: .callback(builder: SvpVC.init), onDismiss: nil)
    }

    <<< ButtonRow() {
      $0.title = "NVActivityIndicatorView"
      $0.presentationMode = .show(controllerProvider: .callback(builder: NvaVC.init), onDismiss: nil)
    }

  }

}


