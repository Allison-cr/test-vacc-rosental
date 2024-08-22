//
//  MainCoordinator.swift
//  test-vacc-rozental
//
//  Created by Alexander Suprun on 22.08.2024.
//

import Foundation
import UIKit

// MARK: - MainCoordinator

final class MainCoordinator: Coordinator {
    
    // MARK: - Properties
       
    private let navigationController: UINavigationController
    
    // MARK: - Initializer
     
    /// Initializes the `MainCoordinator` with a specified navigation controller.
    /// - Parameter navigationController: The navigation controller used to manage view controllers in the main flow.
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Coordinator Lifecycle
     
    /// Starts the main flow by calling the `runMainFlow()` method.
    func start() {
        runMainFlow()
    }
    
    // MARK: - Private Methods
     
    /// Configures and starts the main flow of the application.
    /// This method sets up the `MainViewModel` and `MainViewController`, and pushes the main view onto the navigation stack.
    func runMainFlow() {
        let viewModel = MainViewModel()
        viewModel.coordinator = self
        let mainViewController = MainViewController(viewModel: viewModel)
        navigationController.pushViewController(mainViewController, animated: true)
        viewModel.loadData()
    }
}
