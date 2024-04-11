import Combine

final class FavoritesViewModel {
    
    // MARK: - Public properties
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
    private func bind() {
        coreDataManager.userDishesSubject
            .sink { dishes in
                self.userDishesSubject.send(dishes)
                self.fullUserDishes = dishes
            }
            .store(in: &cancellables)
    }
    
    func loadDishes() {
        coreDataManager.loadDishes()
    }
    
    func searchDishes(_ text: String) {
        if text != "" {
            let filteredDishes = fullUserDishes.filter { $0.favoriteName == text }
            userDishesSubject.send(filteredDishes)
        } else {
            userDishesSubject.send(fullUserDishes)
        }
    }
}
