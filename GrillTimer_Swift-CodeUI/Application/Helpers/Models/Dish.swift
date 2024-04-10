import FirebaseFirestoreSwift

struct Dish: Codable, Hashable {
    
    @DocumentID var id: String?
    var meatType: String
    var dishType: String
    var averageCookingTimes: String
    var instructions: String
    
    
//    var cooking_time: [Double]
//    var doneness: [String]
//    var grill_temperature: [Double]

}
