//
//  MainCoordinator.swift
//  test-vacc-rozental
//
//  Created by Alexander Suprun on 22.08.2024.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
    private let tabBarController: UITabBarController
    private let pages: [TabbarPage] = TabbarPage.allTabbarPages

    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }

    
    override func start() {
        tabBarController.viewControllers?.enumerated().forEach { item in
            guard let controller = item.element as? UINavigationController else { return }
            runMainFlow(item.offset, controller)
        }
    }
    
    func runMainFlow(_ index: Int, _ controller: UINavigationController) {
        let coordinator: Coordinator
        switch pages[index] {
        case .primary:
            coordinator = PrimaryCoordinator(navigationController: controller)
        case .request:
            coordinator = EmptyCoordinator(navigationController: controller)
        case .services:
            coordinator = EmptyCoordinator(navigationController: controller)
        case .chat:
            coordinator = EmptyCoordinator(navigationController: controller)
        case .contacts:
            coordinator = EmptyCoordinator(navigationController: controller)
        }
        addChild(coordinator)
        coordinator.start()
    }
}
