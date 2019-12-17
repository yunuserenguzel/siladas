import UIKit

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
    window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
    return true
  }

}

