import RxSwift
import RxCocoa

enum DataError: Error {
    case error(String)
}

final class DataManager {
    
    static let instanse = DataManager()
    private init() { }
    
    func fetchDishes() -> Observable<[Dish]> {
        
        return Observable.create { observer in
            
            let dishes: [Dish] = [Dish(name: "")] // API
              observer.onNext(dishes)
              observer.onCompleted()
            
              return Disposables.create()
          }
    }
}
