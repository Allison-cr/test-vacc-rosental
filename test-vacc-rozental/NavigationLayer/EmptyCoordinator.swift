//
//  EmptyCoordinator.swift
//  test-vacc-rozental
//
//  Created by Alexander Suprun on 26.08.2024.
//

import UIKit

final class EmptyCoordinator: Coordinator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        runMenuFlow()
    }
    
    func runMenuFlow() {
   
    }
    
}
