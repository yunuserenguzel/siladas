import Foundation

struct Tour: DatabaseObject {
  
  struct Location: Codable {
    var latitude: Double
    var longitude: Double
  }
  
  enum CodingKeys: String, CodingKey {
    case lastLocation = "last-location", key, speed
  }
  
  var key: String
  var speed: Double
  var lastLocation: Location
}

extension Tour.Location {
  static func decode(from dictionary: [String: Any]) throws -> Self {
    let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
    return try JSONDecoder().decode(Self.self, from: data)
  }
  
  func encode() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    return try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as! [String : Any]
  }
}
