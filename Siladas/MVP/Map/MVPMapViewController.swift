import UIKit
import MapKit

final class MVPMapViewController: UIViewController {
  
  dynamic var pins: [String: MKPointAnnotation] = [:]
  
  @IBOutlet weak var mapView: MKMapView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let tourObserver = Services.shared.firebaseConnector.toursObserver
    tourObserver
      .onChildAdded { result in
        guard case let .success(tour) = result else { return }
        self.updatePin(for: tour)
      }
      .onChildChanged { result in
        guard case let .success(tour) = result else { return }
        self.updatePin(for: tour)
      }
  }
  
  private func updatePin(for tour: Tour) {
    let annotation: MKPointAnnotation = {
      if let annotation = pins[tour.key] {
        return annotation
      } else {
        let annotation = MKPointAnnotation()
        mapView.addAnnotation(annotation)
        annotation.title = tour.key
        pins[tour.key] = annotation
        return annotation
      }
    }()
    
    UIView.animate(withDuration: 0.3) {
      annotation.coordinate = CLLocationCoordinate2D(latitude: tour.lastLocation.latitude, longitude: tour.lastLocation.longitude)
    }
  }
  
}
