import UIKit
import Eureka

import RxSwift
import RxCocoa

import MBProgressHUD

import iOSKit

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .debug)

extension MBProgressHUDMode: CustomStringConvertible {
  public var description: String {
    switch self {
    case .text: return "text"
    case .indeterminate: return "indeterminate"
    case .determinate: return "determinate"
    case .annularDeterminate: return "annularDeterminate"
    case .determinateHorizontalBar: return "determinateHorizontalBar"
    case .customView: return "customView"
    }
  }

  public var section: String {
    switch self {
    case .text: return "text"
    case .indeterminate: return "indeterminate"
    case .determinate, .determinateHorizontalBar, .annularDeterminate: return "determinate"
    case .customView: return "customView"
    }
  }
}

extension MBProgressHUDBackgroundStyle: CustomStringConvertible {
  public var description: String {
    switch self {
    case .blur: return "blur"
    case .solidColor: return "solidColor"
    }
  }
}

extension MBProgressHUDAnimation: CustomStringConvertible {
  public var description: String {
    switch self {
    case .fade: return "fade"
    case .zoom: return "zoom"
    case .zoomOut: return "zoomOut"
    case .zoomIn: return "zoomIn"
    }
  }
}

class MbpVC: FormViewController {

  var disposeBag = DisposeBag()

  let mbpCommands = PublishSubject<MBPCommand>()

  let simualteProgressSubject = BehaviorSubject<Bool>(value: false)

  var titleSegment: UISegmentedControl!
  var headerView: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.tableHeaderView = headerView
    form.inlineRowHideOptions = [.AnotherInlineRowIsShown, .FirstResponderChanges]
    edgesForExtendedLayout = []
    automaticallyAdjustsScrollViewInsets = false

    setupHeaderView()
    setupNavigationBar()

    form
      +++ inputSection
      +++ runSection

//    let commandsFromTitleSegment = titleSegment.rx.selectedSegmentIndex
//      .asDriver()
//      .map { [weak self] index -> MBPCommand in
//        guard let ss = self else { return .hide }
//        switch index {
//        case 0:
//          return .hideIn(1)
//        case 1:
//          return ss.makeUpdateCommand()
//        case 2:
//          return .hide
//        default:
//          return .failure(message: "Unexpected title segment index: \(index)")
//        }
//    }
//
//    commandsFromTitleSegment
//      .drive(commandsSubject)
//      .disposed(by: disposeBag)

    Driver<Int>.interval(0.1)
      .scan(0.0 as Double) { acc, _ -> Double in
        var result: Double
        result = acc + (1.0 / 30)
        if result > 1.0 {
          result = 0.0
        }
        return result
      }
      .drive(
        onNext: { [weak self] progress in
          guard let ss = self else { return }
          MBProgressHUD(for: ss.headerView)?.progress = Float(progress)
        }
      )
      .disposed(by: disposeBag)

    mbpCommands
      .asDriver(onErrorJustReturn: .failure(title: nil, message: "Somthing happend ..."))
      .drive(self.headerView.mbp.hud)
      .disposed(by: disposeBag)

    mbpCommands.onNext(makeUpdateCommand())
  }

  func setupHeaderView() {
    headerView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    headerView.clipsToBounds = true
    headerView.image = #imageLiteral(resourceName: "Header")
    headerView.contentMode = .scaleAspectFill
    tableView.tableHeaderView = headerView
  }

  func setupNavigationBar() {
    // title segment
    titleSegment = UISegmentedControl(items: ["Blink", "Show", "Hide"])
    titleSegment.selectedSegmentIndex = 1
    navigationItem.titleView = titleSegment

    // reset button
    let item = UIBarButtonItem()
    item.title = "Reset"
    navigationItem.rightBarButtonItem = item
    item.rx.tap
      .bind(onNext: { [weak self] in
        guard let ss = self else { return }
        ss.form.setValues([
          "title": "iOSKit",
          "message": "Test MBProgressHUD",
          "mode": MBProgressHUDMode.text,
          "animation": MBProgressHUDAnimation.fade,
          "background": MBProgressHUDBackgroundStyle.blur,
          "square": false,
          "margin": 20.0,
          "simualteProgress": false,
        ])
        ss.form[0].reload()
        ss.form[1].reload()
      })
      .disposed(by: disposeBag)
  }

  var inputSection: Section {

    let section = Section("Configure HUD")

    <<< TextRow("title") {
      $0.title = "Title"
      $0.placeholder = "Required"
      $0.value = "iOSKit"
    }.onChange { [weak self] _ in
      self?.updateDemoHUD()
    }

    <<< TextRow("message") {
      $0.title = "Message"
      $0.placeholder = "Optional"
      $0.value = "Test MBProgressHUD"
    }.onChange { [weak self] _ in
      self?.updateDemoHUD()
    }

    <<< PushRow<MBProgressHUDMode>("mode") {
      $0.title = "HUD Layout Mode"
      $0.options = [
          .text,
          .indeterminate,
          .determinate, .determinateHorizontalBar, .annularDeterminate
      ]
      $0.value = .text
      $0.selectorTitle = "HUD modes"
    }.onChange { [weak self] _ in
      self?.updateDemoHUD()
    }.onPresent { from, to in
      to.dismissOnSelection = false
      to.dismissOnChange = false
      to.enableDeselection = false
      to.sectionKeyForValue = { option in return option.section }
    }

    <<< PickerInlineRow<MBProgressHUDAnimation>("animation") {
      $0.title = "Animation Type"
      $0.options = [.fade, .zoom, .zoomOut, .zoomIn]
      $0.value = .fade
    }.onChange { [weak self] _ in
      self?.updateDemoHUD()
    }

    <<< SegmentedRow<MBProgressHUDBackgroundStyle>("background") {
      $0.title = "Background Style    "
      $0.options = [.blur, .solidColor]
      $0.value = .blur
    }.onChange { [weak self] _ in
      self?.updateDemoHUD()
    }

    <<< SwitchRow("square") {
      $0.title = "Keep Square Shape"
      $0.value = false
    }.onChange { [weak self] _ in
      self?.updateDemoHUD()
    }

    <<< StepperRow("margin") {
      $0.title = "Bezel View Margin"
      $0.value = 20 // default
    }.onChange { [weak self] _ in
      self?.updateDemoHUD()
    }

    return section

  }

  var runSection: Section {

    let section = Section("Run")

    <<< ButtonRow() {
      $0.title = "Simulate a Downloading Process"
    }.onCellSelection { [weak self] cell, row in
      guard let ss = self else { return }
      let commands = Observable<MBPCommand>
        .create { observer in
          observer.onNext(.show(title: "Downloading ...") { hud in
            hud.progress = 0
            hud.mode = .annularDeterminate
            hud.minSize = CGSize(width: 160, height: 100)
          })

          var progress = 0.0
          while progress < 1.0 {
            Thread.sleep(forTimeInterval: 0.05)
            observer.onNext(.update(progress: progress))
            progress += 0.02
          }
          if arc4random_uniform(2) == 0 {
            observer.onNext(.failure())
          } else {
            observer.onNext(.success())
          }
          Thread.sleep(forTimeInterval: 2)
          observer.onCompleted()

          return Disposables.create()
        }
        .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .default))

      commands
        .asDriver(onErrorJustReturn: .hide)
        .drive(ss.view.mbp.hud)
        .disposed(by: ss.disposeBag)
    }

    return section

  }

  func makeUpdateCommand() -> MBPCommand {

    let values = form.values()
    let title = values["title"] as? String
    let message = values["message"] as? String
    let mode = values["mode"] as! MBProgressHUDMode
    let animation = values["animation"] as! MBProgressHUDAnimation
    let background = values["background"] as! MBProgressHUDBackgroundStyle
    let isSquare = values["square"] as! Bool
    let margin = CGFloat(values["margin"] as? Double ?? 20.0)

    let command = MBPCommand.show(title: title, message: message, mode: mode) {
      hud in
      hud.animationType = animation
      hud.bezelView.style = background
      hud.isSquare = isSquare
      hud.margin = margin
    }

    return command
  }

  func updateDemoHUD() {
    mbpCommands.onNext(makeUpdateCommand())
  }

}
