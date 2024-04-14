import Foundation

struct DishSaveDTO: Codable, Hashable {
    
    var id: String?
    var meatType: String
    var dishType: String
    var averageCookingTime: Int
    var cookingTime: String
    
    var favoriteName: String?
    var averageFavoriteCookingTime: Int?
    var sizeMeat: Int?
    var grillTemperature: Int?
    var meatTemperature: Int?
    var isMarinade: Bool?
    var currentTime: Date
}

extension DishSaveDTO {
    init(dish: Dish) {
        self.init(id: dish.id, meatType: dish.meatType ?? "", dishType: dish.dishType ?? "", averageCookingTime: Int(dish.averageCookingTime), cookingTime: dish.cookingTime ?? "", favoriteName: dish.favoriteName, averageFavoriteCookingTime: Int(dish.averageFavoriteCookingTime), sizeMeat: Int(dish.sizeMeat), grillTemperature: Int(dish.grillTemperature), meatTemperature: Int(dish.meatTemperature), isMarinade: dish.isMarinade, currentTime: Date())
    }
}
