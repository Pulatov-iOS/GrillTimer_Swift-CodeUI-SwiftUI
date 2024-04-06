import UIKit

final class RootCoordinator {
    
    // MARK: - Private Properties
    private let window: UIWindow
    private let initialNavigationController = UINavigationController()

    private var dishCoordinator: DishCoordinator?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        dishCoordinator = DishCoordinator(rootNavigationController: initialNavigationController)

        if let coordinator = dishCoordinator {
            coordinator.start()
        }
        
        window.rootViewController = initialNavigationController
        window.makeKeyAndVisible()
    }
}
