protocol MapPresenterView: class {
  func set(tours: [Tour])
}

final class MapPresenter {
  
  private weak var view: MapPresenterView?
  private var toursObserver: FirebaseObserver<Tour>
  private var tours: [String: Tour] = [:] {
    didSet {
      view?.set(tours: tours.map { $0.value })
    }
  }
  
  init(view: MapPresenterView,
       toursObserver: FirebaseObserver<Tour> = Services.shared.firebaseConnector.toursObserver) {
    self.toursObserver = toursObserver
    self.view = view
  }
  
  func onViewDidLoad() {
    toursObserver
      .onChildAdded { [weak self] result in
        guard case let .success(tour) = result else { return }
        self?.tours[tour.key] = tour
      }
      .onChildChanged { [weak self] result in
        guard case let .success(tour) = result else { return }
        self?.tours[tour.key] = tour
      }
  }
}
