import Firebase
// TODO: Remove CoreLocation and use domain models
import CoreLocation
  
final class FirebaseConnector {

  // TODO: Remove this
  let userId = "Eren"
  
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
      let data = try JSONEncoder().encode(tour)
      var dict: [String: Any] = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as! [String : Any]
      dict.removeValue(forKey: "key")
      ref.child(userId).setValue(dict)
    } catch {
      print(error)
    }
  }
}
