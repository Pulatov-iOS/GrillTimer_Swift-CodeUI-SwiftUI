import Combine
import FirebaseFirestore
import FirebaseStorage

enum DataError: Error {
    case error(String)
}

enum FirebaseKeys {
    static let pathDishes = "Dish"
}

final class FirebaseManager: NSCopying {
    
    static let instance = FirebaseManager()
    private init(){
        fetchDishes()
    }
    
    // MARK: - Public Properties
    lazy var dishesSubject = CurrentValueSubject<[DishDTO], DataError>([])
    
    // MARK: - Private Properties
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    // MARK: - Methods
    func fetchDishes() {
        let listener = self.db.collection(FirebaseKeys.pathDishes).addSnapshotListener { (snapshot, error) in
            if let error = error {
                self.dishesSubject.send(completion: .failure(.error(error.localizedDescription)))
                return
            }
            
            let dishes = snapshot?.documents.compactMap {
                try? $0.data(as: DishDTO.self)
            } ?? []
            self.dishesSubject.send(dishes)
        }
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return FirebaseManager.instance
    }
}
