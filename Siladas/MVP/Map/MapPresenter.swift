protocol MapPresenterView: class {
  func set(tours: [Tour])
}

final class MapPresenter {
  
  private weak var view: MapPresenterView?
  private var toursObserver: FirebaseObserver<Tour>
  
  init(view: MapPresenterView,
       toursObserver: FirebaseObserver<Tour> = Services.shared.firebaseConnector.toursObserver) {
    self.toursObserver = toursObserver
    self.view = view
  }
  
  func onViewDidLoad() {
    
  }
}
