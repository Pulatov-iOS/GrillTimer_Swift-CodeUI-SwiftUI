import CoreData
import UIKit
import Combine

final class CoreDataManager: NSCopying {
    
    static let instance = CoreDataManager()
    private init() { }
    
    // MARK: - Public Properties
    lazy var userDishesSubject = PassthroughSubject<[Dish], Never>()

    // MARK: - Methods
    func loadDishes() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext  = appDelegate.persistentContainer.viewContext
        let feetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Dish")
        
        do {
            let feetchedObject = try managedContext.fetch(feetchRequest)
            guard let feetchedDishes = feetchedObject as? [Dish] else { return }
            userDishesSubject.send(feetchedDishes)
        } catch {
            return
        }
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return CoreDataManager.instance
    }
}
