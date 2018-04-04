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
   +++ hudSection
 }

 var cellSetup = { (cell: ButtonCell, row: ButtonRow) -> Void in
//    cell.height = { 32 }
//    cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
 }

 // MARK: sections
 var alertSection: Section {
  return Section()
  <<< ButtonRow() { $0.title = "Alert & Action Sheet" }
   .cellSetup(cellSetup)
   .onCellSelection { [weak self] cell, row in
    guard let ss = self else { return }
    ss.performSegue(withIdentifier: "alertVC", sender: ss)
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

}


