import Combine
import FirebaseFirestore
import FirebaseStorage

protocol FirebaseManager: AnyObject {
    static var instance: Self { get }
    var dishesSubject: CurrentValueSubject<[Dish], DataError> { get }
}

enum DataError: Error {
    case error(String)
}

enum FirebaseKeys {
    static let pathDishes = "Dish"
}

final class DefaultFirebaseManager: FirebaseManager, NSCopying {
    
    static let instance = DefaultFirebaseManager()
    private init(){
        fetchDishes()
    }
    
    // MARK: - Public Properties
    lazy var dishesSubject = CurrentValueSubject<[Dish], DataError>([])
    
    // MARK: - Private Properties
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    
    func fetchDishes() {
        let listener = self.db.collection(FirebaseKeys.pathDishes).addSnapshotListener { (snapshot, error) in
            if let error = error {
                self.dishesSubject.send(completion: .failure(.error(error.localizedDescription)))
                return
            }
            
            let dishes = snapshot?.documents.compactMap {
                try? $0.data(as: Dish.self)
            } ?? []
            self.dishesSubject.send(dishes)
        }
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return DefaultFirebaseManager.instance
    }
}
