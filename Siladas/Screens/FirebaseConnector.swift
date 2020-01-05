import Firebase
import FirebaseAuth
// TODO: Remove CoreLocation and use domain models
import CoreLocation
  
final class FirebaseConnector {

  // TODO: Remove this
  var userId: String {
    return Auth.auth().currentUser?.displayName ?? ""
  }
  
  lazy var toursObserver = FirebaseObserver<Tour>(childPath: "tours")
  
  // TODO: Inject LocationService or move responsibility to another class
  private lazy var locationService = LocationService { [weak self] location in
    self?.updateCurrentUser(with: location)
  }
  
  func setup() {
    FirebaseApp.configure()
    Database.database().isPersistenceEnabled = true
  
    locationService.startLocationUpdates()
  }
  
  private func updateCurrentUser(with location: CLLocation) {
    let tour = Tour(key: userId,
                    speed: location.speed,
                    lastLocation: Tour.Location(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude))
    let ref = Database.database().reference(withPath: "tours")
    do {
      ref.child(userId).setValue(try tour.encode())
    } catch {
      print(error)
    }
  }
}
