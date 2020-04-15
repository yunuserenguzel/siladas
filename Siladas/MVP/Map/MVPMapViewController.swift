import UIKit
import MapKit

final class MVPMapViewController: UIViewController {
  
  private dynamic var pins: [String: MKPointAnnotation] = [:]
  
  @IBOutlet weak var mapView: MKMapView!
  
  private var presenter: MapPresenter!
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    
    presenter = MapPresenter(view: self)
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    
    presenter = MapPresenter(view: self)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    presenter.onViewDidLoad()
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

extension MVPMapViewController: MapPresenterView {
  func set(tours: [Tour]) {
    tours.forEach { tour in
      updatePin(for: tour)
    }
  }
}
