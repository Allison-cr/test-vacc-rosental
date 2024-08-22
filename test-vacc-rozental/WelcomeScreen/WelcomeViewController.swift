//
//  WelcomeViewController.swift
//  test-vacc-rozental
//
//  Created by Alexander Suprun on 22.08.2024.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    let viewModel: WelcomeViewModel
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .cyan
//        setupBindings()
//        setupMainView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
