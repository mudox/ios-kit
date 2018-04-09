import UIKit
import Eureka

import RxSwift
import RxCocoa

import MBProgressHUD

import iOSKit

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .debug)

class MbpVC: FormViewController {

  var disposeBag = DisposeBag()

  let mbpCommands = PublishSubject<MBPCommand>()

  let simualteProgressSubject = BehaviorSubject<Bool>(value: false)

  var titleSegment: UISegmentedControl!
  var headerView: UIImageView!

  override func viewDidLoad() {
    super.viewDidLoad()

    form.inlineRowHideOptions = [.AnotherInlineRowIsShown, .FirstResponderChanges]
    tableView.contentInset = UIEdgeInsets(top: 180, left: 0, bottom: 0, right: 0)

    setupHeaderView()
    setupNavigationBar()

    form
      +++ inputSection
      +++ geometrySection
      +++ runSection

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
    headerView = UIImageView()
    headerView.clipsToBounds = true
    headerView.image = #imageLiteral(resourceName: "Header")
    headerView.contentMode = .scaleAspectFill

    view.addSubview(headerView)
    headerView.translatesAutoresizingMaskIntoConstraints = false
    headerView.heightAnchor.constraint(equalToConstant: 180).isActive = true
    headerView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
  }

  func setupNavigationBar() {
    with(navigationItem) { item in
      item.title = "MBP"
    }

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
          "square": false,
          "margin": 20 as Double,
          "width": 120 as Float,
          "height": 90 as Float,
        ])
        ss.tableView.reloadData()
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
      $0.title = "Mode"
      $0.options = [
          .text,
          .indeterminate,
          .determinate, .determinateHorizontalBar, .annularDeterminate
      ]
      $0.value = .text
      $0.selectorTitle = "HUD modes"
      $0.displayValueFor = { $0?.caseName ?? "nil" }
    }.onChange { [weak self] _ in
      self?.updateDemoHUD()
    }.onPresent { from, to in
      to.dismissOnSelection = false
      to.dismissOnChange = false
      to.enableDeselection = false
      to.sectionKeyForValue = {
        switch $0 {
        case .text: return "no progress indicator"
        case .indeterminate: return "a UIActivityIndicatorView spinning"
        case .determinate, .determinateHorizontalBar, .annularDeterminate: return "progress ring or bar"
        case .customView: return "use custom view as indicator"
        }
      }
    }

    <<< PickerInlineRow<MBProgressHUDAnimation>("animation") {
      $0.title = "Animation Type"
      $0.options = [.fade, .zoom, .zoomOut, .zoomIn]
      $0.value = .fade
      $0.displayValueFor = { $0?.caseName ?? "nil" }
    }.onChange { [weak self] row in
      guard let ss = self else { return }
      ss.view.mbp.execute(.success(title: "\(row.value!)") {
        hud in
        hud.animationType = row.value!
      })
    }

    return section

  }

  var geometrySection: Section {

    let section = Section("SIZE AND SHAP")

    <<< SwitchRow("square") {
      $0.title = "Keep Square"
      $0.value = false
    }.onChange { [weak self] _ in
      self?.updateDemoHUD()
    }

    <<< StepperRow("margin") {
      $0.title = "Margin"
      $0.value = 20 // default
    }.onChange { [weak self] _ in
      self?.updateDemoHUD()
    }

    <<< SliderRow("width") {
      $0.title = "Min. Width"
      $0.value = 110
    }.cellSetup { cell, row in
      cell.slider.minimumValue = 50
      cell.slider.maximumValue = 400
    }.onChange { [weak self] _ in
      self?.updateDemoHUD()
    }

    <<< SliderRow("height") {
      $0.title = "Min. Height"
      $0.value = 90
    }.cellSetup { cell, row in
      cell.slider.minimumValue = 50
      cell.slider.maximumValue = 400
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
      ss.simulate()
    }

    return section

  }
  
  func simulate() {
    let commands = Observable<MBPCommand>
      .create { observer in
        observer.onNext(.start(title: "Downloading ...", mode: .annularDeterminate) { hud in
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
      .asDriver(onErrorJustReturn: .failure(title: "Oops!"))
      .drive(view.mbp.hud)
      .disposed(by: disposeBag)
  }

  func makeUpdateCommand() -> MBPCommand {

    let values = form.values()
    let title = values["title"] as? String
    let message = values["message"] as? String
    let mode = values["mode"] as! MBProgressHUDMode
    let isSquare = values["square"] as! Bool
    let margin = CGFloat(values["margin"] as! Double)
    let width = CGFloat(values["width"] as! Float)
    let height = CGFloat(values["height"] as! Float)
    let minSize = CGSize(width: width, height: height)

    let command = MBPCommand.nextStep(title: title, message: message, mode: mode) {
      hud in
      hud.isSquare = isSquare
      hud.margin = margin
      hud.minSize = minSize
    }

    return command
  }

  func updateDemoHUD() {
    mbpCommands.onNext(makeUpdateCommand())
  }

}
