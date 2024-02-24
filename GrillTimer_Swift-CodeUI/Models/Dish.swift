import FirebaseFirestoreSwift

struct Dish: Codable {
    
    @DocumentID var id: String?
    var name: String
}
