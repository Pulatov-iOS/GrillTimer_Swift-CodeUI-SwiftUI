//
//  DishCoordinator.swift
//  GrillTimer_Swift-CodeUI
//
//  Created by Alexander on 6.04.24.
//

import UIKit

final class DishesCoordinator {
    
    private let navigationController: UINavigationController
    private let tabBar: TabBarItem
    
    init(navigationController: UINavigationController, tabBar: TabBarItem) {
        self.navigationController = navigationController
        self.tabBar = tabBar
    }
    
    func start() {
        showDishesScreen()
    }
    
    private func showDishesScreen() {
        let firebaseManager = DefaultFirebaseManager.instance
        
        let view = DishesViewController(tabBar: tabBar)
        let viewModel = DishesViewModel(firebaseManager: firebaseManager)
        view.viewModel = viewModel
        navigationController.setViewControllers([view], animated: false)
        
        viewModel.showDishScreen = { [weak self] dish in
            self?.showDishScreen(dish: dish)
        }
    }
    
    private func showDishScreen(dish: Dish) {
        let view = DishViewController()
        let viewModel = DishViewModel(dish: dish)
        view.viewModel = viewModel
        navigationController.pushViewController(view, animated: true)
    }
}
