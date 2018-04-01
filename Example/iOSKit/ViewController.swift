//
//  ViewController.swift
//  iOSKit
//
//  Created by mudox on 11/13/2017.
//  Copyright (c) 2017 mudox. All rights reserved.
//

import UIKit
import RxSwift
import iOSKit

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .debug)

class ViewController: UIViewController {

  var disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    UIAlertController.mdx.simpleAlert(layout: "Test->Pass")
      .asObservable()
      .take(3, scheduler: MainScheduler.instance)
      .asCompletable()
      .subscribe(
        onCompleted: {
          jack.info("Alert gone!")
        }
      )
      .disposed(by: disposeBag)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

