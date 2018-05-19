import UIKit

import RxSwift
import RxCocoa

import JacKit
fileprivate let jack = Jack.with(levelOfThisFile: .verbose)

public struct MediaPicker {

  /// Pick a image using `UIImagePickerController`, using the default media type `kUTTypeImage`.
  ///
  /// - Parameters:
  ///   - sourceType: The type of picker interface to be displayed by the controller.
  ///   - presenter: The view controller to present the picker controller, if nil
  ///     try using the root view controller. A __error__ may be thrown if the presenter
  ///     is already preseting a view controller.
  ///   - animated: Pass true to animate the presentation; otherwise, pass false.
  ///   - configure: Put custom configuration to the picker controller in it if any.
  ///     Setting the __delegate__ property in this block has no effect.
  /// - Returns: `Single<UIImage>`.
  public static func image(
    from sourceType: UIImagePickerControllerSourceType,
    presenter: UIViewController? = nil,
    animated: Bool = true,
    configure: ((UIImagePickerController) throws -> Void)? = nil
  )
    -> Single<UIImage>
  {
    // precondition: must have a presenting view controller
    guard let presenter = presenter ?? The.rootViewController else {
      return Single.error(CommonError.error("no presenting view controller"))
    }

    let controller = UIImagePickerController()
    controller.sourceType = sourceType

    do {
      try configure?(controller)
    } catch {
      return Single.error(error)
    }

    var delegate: ImagePickerDelegate? = ImagePickerDelegate(for: controller)
    controller.delegate = delegate

    presenter.present(controller, animated: animated)

    // The `.take(1)` operator here
    //   + Completes the sequence on first element (UIImage), which triggers the execution of the disposal
    //     block in the `.do` operator, which, in turn,
    //       - release the strongly hold delegate object.
    //       - dismiss the picker controller.
    //   + Satisfies the requirement from `.asSingle()` below.
    return delegate!.imageSubject
      .take(1)
      .asSingle()
      .do(onDispose: { [weak controller] in
        delegate = nil // strongly hold the delegate object
        controller?.mdx.dismiss(animated: animated)
      })
  }

}

class ImagePickerDelegate: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  weak var controller: UIImagePickerController!

  let imageSubject = PublishSubject<UIImage>()

  init(for controller: UIImagePickerController) {
    self.controller = controller
  }

  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    imageSubject.onError(CommonError.cancelled)
  }

  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
    guard let controller = controller else {
      #if DEBUG
        fatalError("property `controller` should not be nil")
      #else
        imageSubject.onError(CommonError.error("weak property `controller` is nil"))
        return
      #endif
    }

    do {
      let key = controller.allowsEditing
        ? UIImagePickerControllerEditedImage
        : UIImagePickerControllerOriginalImage
      let image = try cast(info[key], to: UIImage.self)
      imageSubject.onNext(image)
    } catch {
      imageSubject.onError(error)
    }
  }

  #if DEBUG
    deinit {
      print("delegate: bye")
    }
  #endif

}
