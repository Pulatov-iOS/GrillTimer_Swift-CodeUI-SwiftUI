import Combine

enum SortingType: String {
    case meat = "Meat"
    case dish = "Dish"
}

final class DishesViewModel {
    
    // MARK: - Public Properties
    let firebaseManager: FirebaseManager
    var showDishScreen: ((DishDTO) -> Void)?
    var dishesSubject: CurrentValueSubject<[DishDTO], DataError> { firebaseManager.dishesSubject }
    var currentSortingSubject = CurrentValueSubject<SortingType, Never>(.dish)
    
    init(firebaseManager: FirebaseManager) {
        self.firebaseManager = firebaseManager
    }
    
    func changedTypeSorting(_ type: SortingType) {
        currentSortingSubject.send(type)
    }
    
    func tableCellTapped(_ dish: DishDTO) {
        showDishScreen?(dish)
    }
}
