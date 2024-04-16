import UIKit

final class DishesCoordinator {
    
    private let rootCoordinator: RootCoordinator
    private let navigationController: UINavigationController
    private let tabBar: TabBarItem
    
    init(rootCoordinator: RootCoordinator, navigationController: UINavigationController, tabBar: TabBarItem) {
        self.rootCoordinator = rootCoordinator
        self.navigationController = navigationController
        self.tabBar = tabBar
    }
    
    func start() {
        showDishesScreen()
    }
    
    private func showDishesScreen() {
        let firebaseManager = FirebaseManager.instance
        let coreDataManager = CoreDataManager.instance
        
        let view = DishesViewController(tabBar: tabBar)
        let viewModel = DishesViewModel(firebaseManager: firebaseManager, coreDataManager: coreDataManager, isFirstStart: rootCoordinator.isFirstStart)
        view.viewModel = viewModel
        navigationController.setViewControllers([view], animated: false)

        rootCoordinator.isFirstStart = false
        
        viewModel.showTimerScreen = { [weak self] dish in
            let timerCoordinator = TimerCoordinator(navigationController: self?.navigationController ?? UINavigationController())
            timerCoordinator.start(dish: dish)
        }
        
        viewModel.showSettingsScreen = { [weak self] in
            let view = SettingsViewController()
            let viewModel = SettingsViewModel()
            view.viewModel = viewModel
            view.navigationItem.setHidesBackButton(true, animated: false)
            self?.navigationController.pushViewController(view, animated: true)
            
            viewModel.dismissScreen = { [weak self] in
                self?.navigationController.popViewController(animated: true)
            }
        }
    }
}
