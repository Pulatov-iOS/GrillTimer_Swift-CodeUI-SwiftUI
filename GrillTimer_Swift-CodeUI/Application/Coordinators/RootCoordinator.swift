import UIKit

final class RootCoordinator {
    
    // MARK: - Private Properties
    private let window: UIWindow
    private let initialNavigationController = UINavigationController()
    private let tabBar = TabBarItem()
    private var selectedTabBarItem: TypeTabBar = .left

    private var dishesCoordinator: DishesCoordinator?
    private var favoritesCoordinator: FavoritesCoordinator?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        tabBar.delegate = self
        
        dishesCoordinator = DishesCoordinator(navigationController: initialNavigationController, tabBar: tabBar)
        favoritesCoordinator = FavoritesCoordinator(navigationController: initialNavigationController, tabBar: tabBar)

        if let coordinator = dishesCoordinator {
            coordinator.start()
        }
        
        window.rootViewController = initialNavigationController
        window.makeKeyAndVisible()
    }
}

extension RootCoordinator: TabBarItemDelegate {
    
    func leftItemTapped(_ cell: TabBarItem) {
        if let coordinator = dishesCoordinator, selectedTabBarItem != .left {
            tabBar.selected(.left)
            selectedTabBarItem = .left
            coordinator.start()
        }
    }
    
    func centerItemTapped(_ cell: TabBarItem) {
        if let coordinator = dishesCoordinator {
            selectedTabBarItem = .center
            coordinator.start()
        }
    }
    
    func rightItemTapped(_ cell: TabBarItem) {
        if let coordinator = favoritesCoordinator, selectedTabBarItem != .right {
            tabBar.selected(.right)
            selectedTabBarItem = .right
            coordinator.start()
        }
    }
}
