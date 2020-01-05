import XCTest
@testable import Siladas

class TourUnitTests: XCTestCase {
  
  func testDictionaryToTour() {
    let dict: [String : Any] = [
      "key": "user-1",
      "speed": 123,
      "last-location": [
        "latitude": 123,
        "longitude": 123
      ]
    ]
    print(dict)
    let tour: Tour!
    do {
      let data = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
      tour = try JSONDecoder().decode(Tour.self, from: data)
    } catch {
      XCTFail("Tour is not being encoded/decoded. Reason: \(error)")
      return
    }
    XCTAssertEqual(tour.key, "user-1")
  }
  
  
  func testTourToDictionary() {
    let tour = Tour(key: "user-id", speed: 123, lastLocation: Tour.Location(latitude: 123, longitude: 123))
     let dict: [String: Any]!
    do {
      let data = try JSONEncoder().encode(tour)
      dict = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [String : Any]
    } catch {
      XCTFail("Tour is not being encoded/decoded. Reason: \(error)")
      return
    }
    XCTAssertEqual(dict["key"] as? String, "user-id")
  }
}
