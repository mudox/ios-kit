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

    form +++ Section("View Controllers")
    <<< ButtonRow() {
      $0.title = "Alert & Action Sheet Layout API"
      $0.presentationMode = .segueName(segueName: "AlertVC", onDismiss: nil)
    }
    <<< ButtonRow() {
      $0.title = "Interactive Navigation Conroller Pop"
      $0.presentationMode = .show(controllerProvider: .callback(builder: NavPopVC.init), onDismiss: nil)
    }
  }

}


