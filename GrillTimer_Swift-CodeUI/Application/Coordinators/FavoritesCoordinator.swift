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
    }
}
