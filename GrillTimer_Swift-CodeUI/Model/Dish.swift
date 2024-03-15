import FirebaseFirestoreSwift

struct Dish: Codable {
    
    @DocumentID var id: String?
    var name: String
    var meatTypes: [String]
    var averageCookingTimes: String
//    var cooking_time: [Double]
//    var doneness: [String]
//    var grill_temperature: [Double]
//    var instructions: String
}
