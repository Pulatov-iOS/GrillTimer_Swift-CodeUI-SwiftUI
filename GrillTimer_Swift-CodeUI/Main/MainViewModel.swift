import Foundation
import RxSwift
import RxCocoa

protocol MainViewModel: AnyObject {
    var dishes: Observable<[Dish]> { get }
    func fetchDishes()
}

final class DefaultMainViewModel {
    
    // MARK: - Properties
    // MARK: Public
    
    // MARK: Private
    private let disposeBag = DisposeBag()
    
    private var dishRelay = BehaviorRelay<[Dish]>(value: [])
    
    // MARK: - API
    
    // MARK: - Helpers
}

// MARK: - MainViewModel
extension DefaultMainViewModel: MainViewModel {
    
    var dishes: Observable<[Dish]> {
        return dishRelay.asObservable()
    }
    
    func fetchDishes() {
        DataManager.instanse.fetchDishes()
            .subscribe(onNext: { [weak self] dishes in
                self?.dishRelay.accept(dishes)
            }, onError: { error in
                // Обработка ошибок при получении данных из Firestore
            })
            .disposed(by: disposeBag)
    }
}
