import UIKit
// Swift
import FirebaseUI

/* ... */

final class LoginViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let authUI = FUIAuth.defaultAuthUI()  
    authUI?.providers = [FUIFacebookAuth()]
    
    guard let controller = authUI?.authViewController() else { return }
    controller.willMove(toParent: self)
    addChild(controller)
    view.addSubview(controller.view)
    controller.didMove(toParent: self)
  }
}
