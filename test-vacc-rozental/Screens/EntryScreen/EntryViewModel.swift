//
//  EntryViewModel.swift
//  test-vacc-rozental
//
//  Created by Alexander Suprun on 22.08.2024.
//

import Foundation

final class EntryViewModel {
    private weak var coordinator: WelcomeCoordinator?
    private let networkService = NetworkService()
    
    init(coordinator: WelcomeCoordinator) {
        self.coordinator = coordinator
    }
    
    func popView() {
        coordinator?.backWelcome()
    }
    
    func goToMainFlow() {
        coordinator?.goToMain()
    }
    
    func login(username: String, password: String) {
        networkService.login(username: username, password: password) { result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.goToMainFlow()
                }
            case .failure:
                DispatchQueue.main.async {
                    print("Login failed")
                }
            }
        }
    }
}

