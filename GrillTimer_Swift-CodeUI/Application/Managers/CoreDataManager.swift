import CoreData
import UIKit
import Combine

enum SaveResult {
    case success
    case error
    case none
}

final class CoreDataManager: NSCopying {
    
    static let instance = CoreDataManager()
    private init() { }
    
    // MARK: - Public Properties
    lazy var userDishesSubject = PassthroughSubject<[Dish], Never>()
    lazy var userSaveDishSubject = PassthroughSubject<DishSaveDTO, Never>()
    let successDishSaveSubject = PassthroughSubject<SaveResult, Never>()
 
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
    
    func loadSaveDish() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext  = appDelegate.persistentContainer.viewContext
        let feetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DishSave")
        
        do {
            let feetchedObject = try managedContext.fetch(feetchRequest)
            guard let feetchedSaveDish = feetchedObject.first as? DishSave else { return }
            let dishSaveDTO = DishSaveDTO(dishSave: feetchedSaveDish)
            userSaveDishSubject.send(dishSaveDTO)
        } catch {
            return
        }
    }
    
    func saveDish(_ dish: DishDTO) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            successDishSaveSubject.send(.error)
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let currancyDishEntity = NSEntityDescription.entity(forEntityName: "Dish", in: managedContext) else {
            successDishSaveSubject.send(.error)
            return
        }
        
        let curDish = NSManagedObject(entity: currancyDishEntity, insertInto: managedContext)

        let dishID = UUID()
        curDish.setValue(dishID.uuidString, forKey: "id")
        curDish.setValue(dish.meatType, forKey: "meatType")
        curDish.setValue(dish.dishType, forKey: "dishType")
        curDish.setValue(dish.averageCookingTime, forKey: "averageCookingTime")
        curDish.setValue(dish.cookingTime, forKey: "cookingTime")
        
        curDish.setValue(dish.favoriteName, forKey: "favoriteName")
        curDish.setValue(dish.averageFavoriteCookingTime, forKey: "averageFavoriteCookingTime")
        curDish.setValue(dish.sizeMeat, forKey: "sizeMeat")
        curDish.setValue(dish.grillTemperature, forKey: "grillTemperature")
        curDish.setValue(dish.meatTemperature, forKey: "meatTemperature")
        curDish.setValue(dish.isMarinade, forKey: "isMarinade")
        
        do {
            try managedContext.save()
            loadDishes()
            successDishSaveSubject.send(.success)
        } catch {
            successDishSaveSubject.send(.error)
            return
        }
    }
    
    func saveStartTimerDish(_ dish: DishSaveDTO) {
        deleteAllDishSaves()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let currancyDishEntity = NSEntityDescription.entity(forEntityName: "DishSave", in: managedContext) else {
            return
        }
        
        let curDish = NSManagedObject(entity: currancyDishEntity, insertInto: managedContext)

        curDish.setValue(dish.id, forKey: "id")
        curDish.setValue(dish.meatType, forKey: "meatType")
        curDish.setValue(dish.dishType, forKey: "dishType")
        curDish.setValue(dish.averageCookingTime, forKey: "averageCookingTime")
        curDish.setValue(dish.cookingTime, forKey: "cookingTime")
        
        curDish.setValue(dish.favoriteName, forKey: "favoriteName")
        curDish.setValue(dish.averageFavoriteCookingTime, forKey: "averageFavoriteCookingTime")
        curDish.setValue(dish.sizeMeat, forKey: "sizeMeat")
        curDish.setValue(dish.grillTemperature, forKey: "grillTemperature")
        curDish.setValue(dish.meatTemperature, forKey: "meatTemperature")
        curDish.setValue(dish.isMarinade, forKey: "isMarinade")
        curDish.setValue(dish.currentTime, forKey: "currentTime")
        curDish.setValue(dish.remainingTimeSeconds, forKey: "remainingTimeSeconds")
        
        do {
            try managedContext.save()
        } catch {
            return
        }
    }
    
    func deleteDish(id: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Dish> = Dish.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)

        do {
            let dishes = try managedContext.fetch(fetchRequest)
            
            for dish in dishes {
                managedContext.delete(dish)
            }
            try managedContext.save()
        } catch {
            return
        }
        
        loadDishes()
    }
    
    func deleteAllDishSaves() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<DishSave> = DishSave.fetchRequest()

        do {
            let dishSaves = try managedContext.fetch(fetchRequest)

            for dishSave in dishSaves {
                managedContext.delete(dishSave)
            }
            try managedContext.save()
        } catch {
            return
        }
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return CoreDataManager.instance
    }
}
