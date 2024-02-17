import Foundation
import RxSwift
import RxCocoa

protocol MainViewModel: AnyObject {
    
}

final class DefaultMainViewModel {
    
    // MARK: - Properties
    // MARK: Public
    
    // MARK: Private
  //  private let dataManager = DataManager.instanse
    private let disposeBag = DisposeBag()
    
    private var dishRelay = BehaviorRelay<[Dish]>(value: [])
       var cars: Observable<[Dish]> {
           return dishRelay.asObservable()
       }
    
    // MARK: - API
    func fetchDishes() {
        DataManager.instanse.fetchDishes()
            .subscribe(onNext: { [weak self] dishes in
                self?.dishRelay.accept(dishes)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Helpers
}

// MARK: - MainViewModel
extension DefaultMainViewModel: MainViewModel {
    
}
