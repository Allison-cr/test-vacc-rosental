//
//  WelcomeCoordinator.swift
//  test-vacc-rozental
//
//  Created by Alexander Suprun on 22.08.2024.
//

import Foundation
import UIKit

// MARK: - MainCoordinator

final class WelcomeCoordinator: Coordinator {
    
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
        let viewModel = WelcomeViewModel(coordinator: self)
        let viewController = WelcomeViewController(viewModel: viewModel)
        navigationController.isNavigationBarHidden = true
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func runEntryFlow() {
        let viewModel = EntryViewModel(coordinator: self)
        let viewController = EntryViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func backWelcome() {
        navigationController.popViewController(animated: true)
    }
    
    func goToMain() {
        let appCoordinator = AppCoordinator(navigationController: self.navigationController)
        appCoordinator.start()
    }
}
