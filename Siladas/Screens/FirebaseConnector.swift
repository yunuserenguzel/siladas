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
    let lastLocation = Tour.Location(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    
    let tourRef = Database.database().reference(withPath: "tours").child(userId)
    
    do {
      let lastLocationEncoded = try lastLocation.encode()
      tourRef.child("last-location").setValue(lastLocationEncoded)
      if let key = tourRef.child("locations").childByAutoId().key {
        tourRef.child("locations").child(key).setValue(lastLocationEncoded)
      }
    } catch {
      print(error)
    }
  }
}
