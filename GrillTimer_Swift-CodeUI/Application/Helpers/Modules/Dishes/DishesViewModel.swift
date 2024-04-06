import Combine

final class DishesViewModel {
    
    // MARK: - Public Properties
    let firebaseManager: FirebaseManager
    var showDishScreen: ((Dish) -> Void)?
    var dishesSubject: CurrentValueSubject<[Dish], DataError> { firebaseManager.dishesSubject }
    
    init(firebaseManager: FirebaseManager) {
        self.firebaseManager = firebaseManager
    }
    
    func tableCellTapped(_ dish: Dish) {
        showDishScreen?(dish)
    }
}
