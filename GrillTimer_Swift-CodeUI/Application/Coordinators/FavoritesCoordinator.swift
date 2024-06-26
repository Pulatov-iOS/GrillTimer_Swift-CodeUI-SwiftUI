import UIKit

final class FavoritesCoordinator {
    
    private let navigationController: UINavigationController
    private let tabBar: TabBarItem
    
    init(navigationController: UINavigationController, tabBar: TabBarItem) {
        self.navigationController = navigationController
        self.tabBar = tabBar
    }
    
    func start() {
        showFavoritesScreen()
    }
    
    private func showFavoritesScreen() {
        let coreDataManager = CoreDataManager.instance
        
        let view = FavoritesViewController(tabBar: tabBar)
        let viewModel = FavoritesViewModel(coreDataManager: coreDataManager)
        view.viewModel = viewModel
        navigationController.setViewControllers([view], animated: false)
        
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
