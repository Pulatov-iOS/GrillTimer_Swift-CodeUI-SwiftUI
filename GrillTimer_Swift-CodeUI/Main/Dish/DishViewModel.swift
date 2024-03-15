import Combine

protocol DishViewModel: AnyObject {
    var dishSubject: CurrentValueSubject<Dish, Never> { get }
}

final class DefaultDishViewModel {
    
    init(dish: Dish) {
        dishSubject.send(dish)
    }
    
    // MARK: Private Properties
    var dishSubject = CurrentValueSubject<Dish, Never>(Dish(name: "", meatTypes: [], averageCookingTimes: ""))
}

// MARK: - DishViewModel
extension DefaultDishViewModel: DishViewModel {

}


