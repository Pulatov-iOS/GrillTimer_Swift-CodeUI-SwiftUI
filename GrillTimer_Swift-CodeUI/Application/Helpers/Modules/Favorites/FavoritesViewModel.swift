import Combine

final class FavoritesViewModel {
    
    // MARK: - Public properties
    var showTimerScreen: ((DishDTO) -> Void)?
    let userDishesSubject = CurrentValueSubject<[Dish], Never>([])
    
    // MARK: - Private properties
    private var fullUserDishes: [Dish] = []
    private var coreDataManager: CoreDataManager
    private var cancellables = Set<AnyCancellable>()
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
        
        bind()
    }
    
    // MARK: - Methods
    func loadDishes() {
        coreDataManager.loadDishes()
    }
    
    func searchDishes(_ text: String) {
        if text != "" {
            let filteredDishes = fullUserDishes.filter { dish in
                if let name = dish.favoriteName {
                    return name.lowercased().contains(text.lowercased())
                } else {
                    return false
                }
            }
            userDishesSubject.send(filteredDishes)
        } else {
            userDishesSubject.send(fullUserDishes)
        }
    }
    
    func deleteSearchResults() {
        userDishesSubject.send(fullUserDishes)
    }
    
    func tableCellTapped(_ dishId: String) {
        if let dish = fullUserDishes.first(where: { $0.id == dishId }) {
            let dishDTO = DishDTO(dish: dish)
            showTimerScreen?(dishDTO)
        }
    }
    
    private func bind() {
        coreDataManager.userDishesSubject
            .sink { dishes in
                self.userDishesSubject.send(dishes)
                self.fullUserDishes = dishes
            }
            .store(in: &cancellables)
    }
}
