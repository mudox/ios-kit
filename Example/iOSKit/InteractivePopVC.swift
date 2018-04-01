import UIKit
import Eureka
import iOSKit

private func == (lhs: InteractivePopNavigationController.InteractivePopStyle, rhs: String) -> Bool {
  return (lhs == .none && rhs == "none")
    || (lhs == .inherit && rhs == "inherit")
    || (lhs == .edge && rhs == "edge")
    || (lhs == .anywhere && rhs == "anywhere")
}

class InteractivePopVC: FormViewController {
  var popStyle: InteractivePopNavigationController.InteractivePopStyle {
    get {
      let vc = The.mainWindow.rootViewController as! InteractivePopNavigationController
      return vc.interactivePopStyle
    }
    set {
      let vc = The.mainWindow.rootViewController as! InteractivePopNavigationController
      vc.interactivePopStyle = newValue
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    let section = Section("Interactive pop styles")
    for style in ["none", "inherit", "edge", "anywhere"] {
      let row = ButtonRow() { $0.title = style }
        .cellSetup { cell, row in
          cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
          cell.textLabel?.textAlignment = .left
          cell.selectionStyle = .default
          cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }.cellUpdate { [weak self] cell, row in
          guard let ss = self else { return }
          if ss.popStyle == style {
            cell.textLabel?.textColor = .green
          } else {
            cell.textLabel?.textColor = .lightGray
          }
        }
        .onCellSelection { [weak self] cell, row in
          guard let ss = self else { return }
          switch style {
          case "none": ss.popStyle = .none
          case "inherit": ss.popStyle = .inherit
          case "edge": ss.popStyle = .edge
          case "anywhere": ss.popStyle = .anywhere
          default:
            fatalError()
          }
          ss.tableView.reloadData()
      }
      section <<< row
    }

    form +++ section
  }
}

