import UIKit

final class DishesCoordinator {
    
    private let navigationController: UINavigationController
    private let tabBar: TabBarItem
    
    init(navigationController: UINavigationController, tabBar: TabBarItem) {
        self.navigationController = navigationController
        self.tabBar = tabBar
    }
    
    func start() {
        showDishesScreen()
    }
    
    private func showDishesScreen() {
        let firebaseManager = FirebaseManager.instance
        
        let view = DishesViewController(tabBar: tabBar)
        let viewModel = DishesViewModel(firebaseManager: firebaseManager)
        view.viewModel = viewModel
        navigationController.setViewControllers([view], animated: false)
        
        viewModel.showDishScreen = { [weak self] dish in
            let timerCoordinator = TimerCoordinator(navigationController: self?.navigationController ?? UINavigationController())
            timerCoordinator.start(dish: dish)
        }
    }
}
