import Combine

final class DishViewModel {
    
    init(dish: Dish) {
        dishSubject.send(dish)
    }
    
    // MARK: Private Properties
    var dishSubject = CurrentValueSubject<Dish, Never>(Dish(meatType: "", dishType: "", averageCookingTimes: "", instructions: ""))
}



