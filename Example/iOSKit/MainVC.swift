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
    
    form
      +++ alertSection
      +++ navSection
  }

  var cellSetup = { (cell: ButtonCell, row: ButtonRow) -> Void in
//    cell.height = { 36 }
//    cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
  }

  var alertSection: Section {
    return Section()
    <<< ButtonRow() { $0.title = "Simple Alert" }
      .cellSetup(cellSetup)
      .onCellSelection { [weak self] cell, row in
        guard let ss = self else { return }
        UIAlertController.mdx.simpleAlert(layout: "Test->Pass")
          .asObservable()
          .take(5, scheduler: MainScheduler.instance)
          .asCompletable()
          .subscribe(
            onCompleted: {
              jack.info("Alert gone!")
            }
          )
          .disposed(by: ss.disposeBag)
    }
    <<< ButtonRow() { $0.title = "Action Sheet" }
      .cellUpdate(cellSetup)
      .onCellSelection { [weak self] cell, row in
        guard let ss = self else { return }
        UIAlertController.mdx.actionSheet(layout: "Action Sheet:Choose one of the 4 actions->OK|Cancel[c]|Destroy[d]|Other")
          .subscribe(
            onSuccess: { title in
              jack.info("User select action: \(title)")
            }
          )
          .disposed(by: ss.disposeBag)
    }
  }

  var navSection: Section {
    return Section()
    <<< ButtonRow() { $0.title = "Interactive Pop Gesture" }
      .cellUpdate(cellSetup)
      .onCellSelection { [weak self] cell, row in
        guard let ss = self else { return }
        ss.performSegue(withIdentifier: "interactivePopVC", sender: ss)
    }
  }
}


