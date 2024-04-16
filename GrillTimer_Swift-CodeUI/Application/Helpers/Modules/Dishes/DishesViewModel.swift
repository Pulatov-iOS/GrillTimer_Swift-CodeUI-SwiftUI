import Combine

enum SortingType: String {
    case meat = "Meat"
    case dish = "Dish"
}

final class DishesViewModel {
    
    // MARK: - Public Properties
    var showTimerScreen: ((DishSaveDTO) -> Void)?
    var showSettingsScreen: (() -> Void)?
    var dishesSubject: CurrentValueSubject<[DishDTO], DataError> { firebaseManager.dishesSubject }
    var currentSortingSubject = CurrentValueSubject<SortingType, Never>(.dish)
    
    // MARK: - Private Properties
    private let firebaseManager: FirebaseManager
    private let coreDataManager: CoreDataManager
    private let isFirstStart: Bool
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    init(firebaseManager: FirebaseManager, coreDataManager: CoreDataManager, isFirstStart: Bool) {
        self.firebaseManager = firebaseManager
        self.coreDataManager = coreDataManager
        self.isFirstStart = isFirstStart
        
        bind()
    }
    
    // MARK: - Methods
    func loadSaveDish() {
        if self.isFirstStart == true {
            coreDataManager.loadSaveDish()
        }
    }
    
    func changedTypeSorting(_ type: SortingType) {
        currentSortingSubject.send(type)
    }
    
    func tableCellTapped(_ dishId: String) {
        if let dish = dishesSubject.value.first(where: { $0.id == dishId }) {
            showTimerScreen?(DishSaveDTO(dish: dish))
        }
    }
    
    func settingsButtonTapped(){
        showSettingsScreen?()
    }
    
    private func bind() {
        coreDataManager.userSaveDishSubject
            .sink { [weak self] dish in
                if dish.currentTime != nil {
                    self?.showTimerScreen?(dish)
                }
            }
            .store(in: &cancellables)
    }
}
