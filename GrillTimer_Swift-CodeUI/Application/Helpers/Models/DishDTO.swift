import FirebaseFirestoreSwift

struct DishDTO: Codable, Hashable {
    
    @DocumentID var id: String?
    var meatType: String
    var dishType: String
    var averageCookingTimes: String
    var instructions: String
    
    var favoriteName: String?
    var cookingTime: String?
}
