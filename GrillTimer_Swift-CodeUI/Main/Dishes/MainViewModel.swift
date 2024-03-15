import Combine

protocol MainViewModel: AnyObject {
    var dishesSubject: CurrentValueSubject<[Dish], DataError> { get }
    func tableCellTapped(_ dish: Dish)
}

final class DefaultMainViewModel {
    
    // MARK: - Public Properties
    let firebaseManager: FirebaseManager
    var showDishScreen: ((Dish) -> Void)?
    var dishesSubject: CurrentValueSubject<[Dish], DataError> { firebaseManager.dishesSubject }
    
    init(firebaseManager: FirebaseManager) {
        self.firebaseManager = firebaseManager
    }
    
}

// MARK: - MainViewModel
extension DefaultMainViewModel: MainViewModel {
    
    func tableCellTapped(_ dish: Dish) {
        showDishScreen?(dish)
    }
}
