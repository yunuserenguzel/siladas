import Foundation
import CoreLocation

final class LocationService: NSObject, CLLocationManagerDelegate {
  
  private lazy var locationManager = CLLocationManager()
  private var onLocationReceived: (CLLocation) -> Void
  
  init(onLocationReceived: @escaping (CLLocation) -> Void) {
    self.onLocationReceived = onLocationReceived
  }
  
  func startLocationUpdates() {
    locationManager.requestWhenInUseAuthorization()

    locationManager.delegate = self
    locationManager.showsBackgroundLocationIndicator = false
    locationManager.activityType = .automotiveNavigation
//    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.allowsBackgroundLocationUpdates = true
    locationManager.distanceFilter = 200
    locationManager.startUpdatingLocation()
  }
  
  func stopLocationUpdates() {
    locationManager.stopUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.first else { return }
    onLocationReceived(location)
  }
  
}
