import Foundation

protocol DatabaseObject: Codable {
  var key: String { get set }
}

extension DatabaseObject {
  
  static func decode(from dictionary: [String: Any], forKey key: String) throws -> Self {
    var dictionary = dictionary
    dictionary["key"] = key
    let data = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
    return try JSONDecoder().decode(Self.self, from: data)
  }
  
  func encode() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    var dictionary: [String: Any] = try JSONSerialization.jsonObject(
      with: data, options: .fragmentsAllowed) as! [String : Any]
    dictionary.removeValue(forKey: "key")
    return dictionary
  }
}
