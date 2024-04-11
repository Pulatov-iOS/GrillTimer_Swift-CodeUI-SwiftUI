//
//  FavoritesCoordinator.swift
//  GrillTimer_Swift-CodeUI
//
//  Created by Alexander on 11.04.24.
//

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
        let view = FavoritesViewController(tabBar: tabBar)
        let viewModel = FavoritesViewModel()
        view.viewModel = viewModel
        navigationController.setViewControllers([view], animated: false)
    }
}
