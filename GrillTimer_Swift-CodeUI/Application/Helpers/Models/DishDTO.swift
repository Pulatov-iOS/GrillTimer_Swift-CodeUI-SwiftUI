import FirebaseFirestoreSwift

struct DishDTO: Codable, Hashable {
    
    @DocumentID var id: String?
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
}
