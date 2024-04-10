import UIKit

final class RootCoordinator {
    
    // MARK: - Private Properties
    private let window: UIWindow
    private let initialNavigationController = UINavigationController()
    private let tabBar = TabBarItem()
    private var selectedTabBarItem: TypeTabBar = .left

    private var dishCoordinator: DishCoordinator?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        tabBar.delegate = self
        
        dishCoordinator = DishCoordinator(navigationController: initialNavigationController, tabBar: tabBar)

        if let coordinator = dishCoordinator {
            coordinator.start()
        }
        
        window.rootViewController = initialNavigationController
        window.makeKeyAndVisible()
    }
}

extension RootCoordinator: TabBarItemDelegate {
    
    func leftItemTapped(_ cell: TabBarItem) {
        if let coordinator = dishCoordinator, selectedTabBarItem != .left {
            tabBar.selected(.left)
            selectedTabBarItem = .left
            coordinator.start()
        }
    }
    
    func centerItemTapped(_ cell: TabBarItem) {
        if let coordinator = dishCoordinator {
            selectedTabBarItem = .center
            coordinator.start()
        }
    }
    
    func rightItemTapped(_ cell: TabBarItem) {
        if let coordinator = dishCoordinator, selectedTabBarItem != .right {
            tabBar.selected(.right)
            selectedTabBarItem = .right
            coordinator.start()
        }
    }
}
