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
