//
//  PrimaryCoordinator.swift
//  test-vacc-rozental
//
//  Created by Alexander Suprun on 22.08.2024.
//

import UIKit

final class PrimaryCoordinator: Coordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        runMenuFlow()
    }
    
    func runMenuFlow() {
        let networkService = NetworkService()
        let decodeService = DecodeDashboardData(networkService: networkService)
        let viewModel = PrimaryViewModel(decodeService: decodeService)
        let viewController = PrimaryViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
