//
//  MainTableViewController.swift
//  iOSKit_Example
//
//  Created by Mudox on 01/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import iOSKit

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .debug)

class MainTableViewController: UITableViewController {

  var disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = nil
    tableView.delegate = nil

    let menu = Observable<[(String, String)]>.just([
      ("Simple Alert", "Automatically dismissed in 5 seconds!"),
      ("Action Sheet", "Tap an action to dismiss it"),
    ])

    menu.bind(to: tableView.rx.items(cellIdentifier: "Cell")) {
      row, element, cell in
      cell.textLabel?.text = element.0
      cell.detailTextLabel?.text = element.1
    }.disposed(by: disposeBag)

    tableView.rx.modelSelected((String, String).self).bind(onNext: {
      [weak self] item in
      guard let ss = self else { return }
      
      ss.tableView.deselectRow(at: ss.tableView.indexPathForSelectedRow!, animated: true)
      
      switch item.0 {
      case "Simple Alert":
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
      case "Action Sheet":
        UIAlertController.mdx.actionSheet(layout: "Title:Message->OK|Cancel[c]|Destroy[d]|Other")
          .subscribe(
            onSuccess: { title in
              jack.info("User select action: \(title)")
            }
          )
          .disposed(by: ss.disposeBag)
      default:
        fatalError("Unhandled case: \(item.0)")
      }
    }).disposed(by: disposeBag)
  }

}
