import UIKit

import RxSwift
import RxCocoa

import Eureka

import iOSKit

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .verbose)


class ImagePickerVC: FormViewController {

  var disposeBag = DisposeBag()

  override func viewDidLoad() {
    super.viewDidLoad()

    setupForm()
  }
  
  var sourceType: UIImagePickerControllerSourceType {
    return form.values()["sourceType"] as! UIImagePickerControllerSourceType
  }

  fileprivate func setupForm() {

    form.inlineRowHideOptions = [.AnotherInlineRowIsShown, .FirstResponderChanges]
    
    form +++ Section("SETTINGS")

    <<< PickerInlineRow<UIImagePickerControllerSourceType>("sourceType") {
      $0.title = "Source Type"
      $0.options = [.camera, .photoLibrary, .savedPhotosAlbum].filter {
        UIImagePickerController.isSourceTypeAvailable($0)
      }
      $0.value = $0.options.first!
      $0.displayValueFor = { $0?.caseName ?? "nil" }
    }

    form +++ Section()

    <<< ButtonRow() {
      $0.title = "Present"
    }.onCellSelection { [weak self] cell, row in
      guard let ss = self else { return }
      MediaPicker
        .image(from: ss.sourceType, presenter: ss)
        .subscribe(onSuccess: { print("image: \($0)") }, onError: { print("error: \($0)") })
        .disposed(by: ss.disposeBag)
    }
  }

}
