import UIKit
import RxSwift
import RxCocoa

import iOSKit

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .debug)

private struct ViewModel {
 // outputs
 let tip: Driver<String>
 let showButtonEnabled: Driver<Bool>
 let showAlert: Driver<(style: UIAlertControllerStyle, layout: String)>

 init(
  showButtonTap: ControlEvent<Void>,
  styleSegmentIndex: ControlProperty<Int>,
  layoutInput: Driver<String>
 ) {
  let parseResult = layoutInput
   .distinctUntilChanged()
   .map { text -> (tip: String, layout: String?, error: Error?) in
    do {
     let alertLayout = try AlertLayout(layout: text)
     return (ViewModel.tip(for: alertLayout), text, nil)
    } catch {
     if text.isEmpty {
      return ("Try input `Title:Message->OK`", nil, error)
     } else {
      return (ViewModel.tip(for: error), nil, error)
     }
    }
  }

  tip = parseResult.map { $0.tip }

  let layout = parseResult
   .filter { $0.error == nil }
   .map { $0.layout! }

  let paramters = Driver.combineLatest(styleSegmentIndex.asDriver(), layout) {
   index, layoutText -> (style: UIAlertControllerStyle, layout: String) in
   return (
    style: (index == 0) ? .alert : .actionSheet,
    layout: layoutText
   )
  }

  showAlert = showButtonTap.asDriver().withLatestFrom(paramters)

  showButtonEnabled = parseResult.map { $0.error == nil }
 }

 static func tip(for alertLayout: AlertLayout) -> String {
  func string(for style: UIAlertActionStyle) -> String {
   switch style {
   case .default: return "default"
   case .cancel: return "cancel"
   case .destructive: return "destructive"
   }
  }
  var tip = """
    Title: \(alertLayout.title ?? "n/a")
    Message: \(alertLayout.message ?? "n/a")
    Actions:
    """
  alertLayout.actions.forEach {
   tip.append("\n  - \($0.title) @\(string(for: $0.style))")
  }
  return tip
 }

 static func tip(for error: Error) -> String {
  return """
    Error: \(error)
    """
 }
}

class AlertVC: UITableViewController {

 @IBOutlet weak var showButton: UIBarButtonItem!
 @IBOutlet weak var styleSegment: UISegmentedControl!
 @IBOutlet weak var layoutInput: UITextView!
 @IBOutlet weak var tipView: UITextView!

 var disposeBag = DisposeBag()

 override func viewDidLoad() {
  super.viewDidLoad()

  let vm = ViewModel(
   showButtonTap: showButton.rx.tap,
   styleSegmentIndex: styleSegment.rx.selectedSegmentIndex,
   layoutInput: layoutInput.rx.text.asDriver().map { $0 ?? "" }
  )

  vm.showButtonEnabled.drive(showButton.rx.isEnabled).disposed(by: disposeBag)
  vm.tip.drive(tipView.rx.text).disposed(by: disposeBag)
  vm.showAlert.asObservable()
   .flatMap { param in
    return UIAlertController.mdx.present(layout: param.layout, style: param.style)
   }
   .subscribe (
    onNext: {
     jack.info("User select action: \($0)")
    }
   ).disposed(by: disposeBag)

 }

}

