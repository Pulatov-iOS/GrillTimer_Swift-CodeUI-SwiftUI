import Combine

enum SortingType: String {
    case meat = "Meat"
    case dish = "Dish"
}

final class DishesViewModel {
    
    // MARK: - Public Properties
    var showTimerScreen: ((DishDTO) -> Void)?
    var dishesSubject: CurrentValueSubject<[DishDTO], DataError> { firebaseManager.dishesSubject }
    var currentSortingSubject = CurrentValueSubject<SortingType, Never>(.dish)
    
    // MARK: - Private Properties
    private  let firebaseManager: FirebaseManager
    
    init(firebaseManager: FirebaseManager) {
        self.firebaseManager = firebaseManager
    }
    
    func changedTypeSorting(_ type: SortingType) {
        currentSortingSubject.send(type)
    }
    
    func tableCellTapped(_ dishId: String) {
        if let dish = dishesSubject.value.first(where: { $0.id == dishId }) {
            showTimerScreen?(dish)
        }
    }
}
