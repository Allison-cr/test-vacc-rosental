//
//  WelcomeViewModel.swift
//  test-vacc-rozental
//
//  Created by Alexander Suprun on 22.08.2024.
//

import Foundation

final class WelcomeViewModel {
    private weak var coordinator: WelcomeCoordinator?
    
    init(coordinator: WelcomeCoordinator) {
         self.coordinator = coordinator
     }
    
    func goNextScreen() {
        coordinator?.runEntryFlow()
    }
    
    func goBackScreen() {
        coordinator?.backWelcome()
    }
}
