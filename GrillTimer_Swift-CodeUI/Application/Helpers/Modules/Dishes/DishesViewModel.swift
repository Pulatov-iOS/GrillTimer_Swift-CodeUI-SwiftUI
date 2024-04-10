import Combine

enum SortingType: String {
    case meat = "Meat"
    case dish = "Dish"
}

final class DishesViewModel {
    
    // MARK: - Public Properties
    let firebaseManager: FirebaseManager
    var showDishScreen: ((Dish) -> Void)?
    var dishesSubject: CurrentValueSubject<[Dish], DataError> { firebaseManager.dishesSubject }
    var currentSortingSubject = CurrentValueSubject<SortingType, Never>(.dish)
    
    init(firebaseManager: FirebaseManager) {
        self.firebaseManager = firebaseManager
    }
    
    func changedTypeSorting(_ type: SortingType) {
        currentSortingSubject.send(type)
    }
    
    func tableCellTapped(_ dish: Dish) {
        showDishScreen?(dish)
    }
}
