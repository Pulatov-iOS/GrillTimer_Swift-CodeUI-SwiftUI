import RxSwift
import RxCocoa
import FirebaseFirestore
import FirebaseStorage

enum DataError: Error {
    case error(String)
}

final class DataManager {
    
    static let instanse = DataManager()
    private init(){ }
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    private let pathDishes = "Dish"

    
    func fetchDishes() -> Observable<[Dish]> {
        return Observable.create { observer in
            let listener = self.db.collection(self.pathDishes).addSnapshotListener { (snapshot, error) in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                let dishes = snapshot?.documents.compactMap {
                    try? $0.data(as: Dish.self)
                } ?? []
                observer.onNext(dishes)
            }
               
            return Disposables.create {
                listener.remove()
            }
        }
    }
}
