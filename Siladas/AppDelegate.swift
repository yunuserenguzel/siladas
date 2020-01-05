import UIKit
import FirebaseAuth
import FirebaseUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  private var services = Services.shared
  var observer: FirebaseObserver<Tour>!

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    if UserDefaults.standard.bool(forKey: "isTest") == true {
      return true
    }
    
    services.firebaseConnector.setup()
    observer = FirebaseObserver<Tour>(childPath: "tours")
    observer.onChildAdded { (result) in
      print(result)
    }
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()

    //    window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    
//    window?.rootViewController = UIStoryboard(name: "LoginViewController", bundle: nil).instantiateInitialViewController()
    
    checkAuthenticationAndTransition()
    return true
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
    let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
    if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
      return true
    }
    // other URL handling goes here.
    return false
  }
  
  private func checkAuthenticationAndTransition() {
    if let _ = Auth.auth().currentUser {
      showContent()
    } else {
      showLogin()
    }
  }
  
  private func showContent() {
    window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
  }
  
  private func showLogin() {
    let authUI = FUIAuth.defaultAuthUI()
    authUI?.providers = [FUIFacebookAuth()]
    authUI?.delegate = self
    let controller = authUI?.authViewController()
    window?.rootViewController = controller
  }

}

extension AppDelegate: FUIAuthDelegate {
  func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, url: URL?, error: Error?) {
      checkAuthenticationAndTransition()
  }
}
