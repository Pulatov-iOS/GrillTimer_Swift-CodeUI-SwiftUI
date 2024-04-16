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
    var currentTime: Date?
    var remainingTimeSeconds: Int?
}

extension DishSaveDTO {
    init(dish: DishDTO) {
        self.init(id: dish.id, meatType: dish.meatType ?? "", dishType: dish.dishType ?? "", averageCookingTime: dish.averageCookingTime, cookingTime: dish.cookingTime ?? "", favoriteName: dish.favoriteName, averageFavoriteCookingTime: dish.averageFavoriteCookingTime, sizeMeat: dish.sizeMeat, grillTemperature: dish.grillTemperature, meatTemperature: dish.meatTemperature, isMarinade: dish.isMarinade)
    }
    
    init(dishSave: DishSave) {
        self.init(id: dishSave.id, meatType: dishSave.meatType ?? "", dishType: dishSave.dishType ?? "", averageCookingTime: Int(dishSave.averageCookingTime), cookingTime: dishSave.cookingTime ?? "", favoriteName: dishSave.favoriteName, averageFavoriteCookingTime: Int(dishSave.averageFavoriteCookingTime), sizeMeat: Int(dishSave.sizeMeat), grillTemperature: Int(dishSave.grillTemperature), meatTemperature: Int(dishSave.meatTemperature), isMarinade: dishSave.isMarinade, currentTime: dishSave.currentTime, remainingTimeSeconds: Int(dishSave.remainingTimeSeconds))
    }
}
