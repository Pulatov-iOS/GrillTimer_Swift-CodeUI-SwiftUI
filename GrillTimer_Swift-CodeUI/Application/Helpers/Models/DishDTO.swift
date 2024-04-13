import FirebaseFirestoreSwift

struct DishDTO: Codable, Hashable {
    
    @DocumentID var id: String?
    var meatType: String
    var dishType: String
    var averageCookingTime: Int
    var сookingTime: String
    
    var favoriteName: String?
    var saveCookingTime: Int?
}
