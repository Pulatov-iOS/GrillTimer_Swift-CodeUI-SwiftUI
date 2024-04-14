import UIKit
import SwiftUI

final class TimerCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start(dish: DishDTO?) {
        showTimerScreen(dish)
    }
    
    private func showTimerScreen(_ dish: DishDTO?) {
        let coreDataManager = CoreDataManager.instance
        
        let viewModel = TimerViewModel(dish: dish, coreDataManager: coreDataManager)
        let view = UIHostingController(rootView: TimerView().environmentObject(viewModel))
        
        navigationController.modalPresentationStyle = .formSheet
        navigationController.present(view, animated: true)
    }
}
