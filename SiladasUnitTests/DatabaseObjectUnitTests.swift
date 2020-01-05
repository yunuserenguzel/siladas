import XCTest
@testable import Siladas

private struct TestObject: DatabaseObject {
  var key: String
  var value1: String
  var value2: Int
}

class DatabaseObjectUnitTests: XCTestCase {
  
  var key = "a-key"
  var value1 = "1st value"
  var value2 = 2
  
  func testDecodeDatabaseObject() {
    let testDict: [String: Any] = ["value1": value1, "value2": value2]
    
    let testObject = try? TestObject.decode(from: testDict, forKey: key)
    XCTAssertNotNil(testObject)
    XCTAssertEqual(testObject?.key, key)
    XCTAssertEqual(testObject?.value1, value1)
    XCTAssertEqual(testObject?.value2, value2)
  }
  
  func testEncodeDatabaseObject() {
    let testObject = TestObject(key: key, value1: value1, value2: value2)
    
    let testDict = try? testObject.encode()
    
    XCTAssertNotNil(testDict)
    XCTAssertNil(testDict?["key"])
    XCTAssertEqual(testDict?["value1"] as? String, value1)
    XCTAssertEqual(testDict?["value2"] as? Int, value2)
  }
}
