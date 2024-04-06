//
//  DishCoordinator.swift
//  GrillTimer_Swift-CodeUI
//
//  Created by Alexander on 6.04.24.
//

import UIKit

final class DishCoordinator {
    
    let rootNavigationController: UINavigationController
    
    init(rootNavigationController: UINavigationController) {
        self.rootNavigationController = rootNavigationController
    }
    
    func start() {
        showDishScreen()
    }
    
    private func showDishScreen() {
        let firebaseManager = DefaultFirebaseManager.instance
        
        let view = DefaultMainViewController()
        let viewModel = DefaultMainViewModel(firebaseManager: firebaseManager)
        view.viewModel = viewModel
        rootNavigationController.pushViewController(view, animated: true)
        
        viewModel.showDishScreen = { [weak self] dish in
            self?.showDishScreen(dish: dish)
        }
    }
    
    private func showDishScreen(dish: Dish) {
        let view = DefaultDishViewController()
        let viewModel = DefaultDishViewModel(dish: dish)
        view.viewModel = viewModel
        rootNavigationController.pushViewController(view, animated: true)
    }
}
