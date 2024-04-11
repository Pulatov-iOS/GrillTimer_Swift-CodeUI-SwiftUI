import UIKit
import SwiftUI

final class TimerCoordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showTimerScreen()
    }
    
    private func showTimerScreen() {
        let viewModel = TimerViewModel()
        let view = UIHostingController(rootView: TimerView().environmentObject(viewModel))
        
        navigationController.modalPresentationStyle = .formSheet
        navigationController.present(view, animated: true)
    }
}
