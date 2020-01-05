import Firebase

enum Result<T> {
  case success(T)
  case error(Swift.Error)
}

typealias ResultCallback<T> = (Result<T>) -> Void

final class FirebaseObserver<T: DatabaseObject> {
  
  private let ref: DatabaseReference
  
  init(childPath: String) {
    ref = Database.database().reference().child(childPath)
  }
  
  @discardableResult
  func onChildAdded(_ childAdded: @escaping ResultCallback<T>) -> Self {
    ref.observe(.childAdded, with: makeObserverClosure(forResult: childAdded))
    return self
  }
  
  @discardableResult
  func onChildRemoved(_ childRemoved: @escaping ResultCallback<T>) -> Self {
    ref.observe(.childRemoved, with: makeObserverClosure(forResult: childRemoved))
    return self
  }
  
  @discardableResult
  func onChildChanged(_ childChanged: @escaping ResultCallback<T>) -> Self {
    ref.observe(.childChanged, with: makeObserverClosure(forResult: childChanged))
    return self
  }
  
  @discardableResult
  func onChildMoved(_ childMoved: @escaping ResultCallback<T>) -> Self {
    ref.observe(.childMoved, with: makeObserverClosure(forResult: childMoved))
    return self
  }
  
  private func makeObserverClosure(forResult resultCallback: @escaping ResultCallback<T>) -> ((DataSnapshot) -> Void) {
    return { [weak self] snapshot in
      guard let self = self else { return }
      do {
        let object = try self.extractDatabaseObject(from: snapshot)
        resultCallback(.success(object))
      } catch {
        resultCallback(.error(error))
      }
    }
  }
  
  private func extractDatabaseObject(from snapshot: DataSnapshot) throws -> T {
    guard let dict = snapshot.value as? [String: Any] else {
      throw Error.snapshotNotADictionary
    }
    return try T.decode(from: dict, forKey: snapshot.key)
  }
}

extension FirebaseObserver {
  enum Error: Swift.Error {
    case snapshotNotADictionary
  }
}
