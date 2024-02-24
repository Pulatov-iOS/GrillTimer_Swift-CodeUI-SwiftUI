import UIKit

final class Coordinator {
    
    let rootNavigationController: UINavigationController
    
    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }
    
    func start() {
        showMainScreen()
    }
    
    private func showMainScreen() {
        let view = DefaultMainView()
        let viewModel = DefaultMainViewModel()
        view.viewModel = viewModel
        rootNavigationController.pushViewController(view, animated: true)
    }
}
