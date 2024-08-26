//
//  WelcomeViewController.swift
//  test-vacc-rozental
//
//  Created by Alexander Suprun on 22.08.2024.
//

import UIKit

final class WelcomeViewController: UIViewController {
    
    let viewModel: WelcomeViewModel
    
    private lazy var welcomeLabel: UILabel = setupWelcomeLabel()
    private lazy var welcomeImage: UIImageView = setupWelcomeImage()
    private lazy var authorizationLabel: UILabel = setupAuthorizationLabel()
    
    private lazy var entryButton: UIButton = setupEntryButton()
    private lazy var registrationButton: UIButton = setupRegistrationButton()
    private lazy var inviteButton: UIButton = setupInviteButton()
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        setupMainView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WelcomeViewController {
    @objc func nextEntryScreen() {
        viewModel.goNextScreen()
    }
}

extension WelcomeViewController {
    func setupMainView() {
        setupLayout()
    }
}

extension WelcomeViewController {
    private func setupWelcomeLabel() -> UILabel {
        let label = UILabel()
        label.text = Resources.Strings.Welcome.title
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }
    
    private func setupWelcomeImage() -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(named: "welcome")
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        return image
    }
    
    private func setupAuthorizationLabel() -> UILabel {
        let label = UILabel()
        label.text = Resources.Strings.Welcome.auth
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16,weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }
    
    private func setupEntryButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = .welcomeButton
        button.setTitle(Resources.Strings.Welcome.entryButton, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(
            self,
            action: #selector(nextEntryScreen),
            for: .touchUpInside
        )
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }
    
    private func setupRegistrationButton() -> UIButton {
        let button = UIButton()
        button.setTitle(Resources.Strings.Welcome.registrationButton, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }
    
    private func setupInviteButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "house"), for: .normal)
        button.tintColor = .blue
        button.setTitle(Resources.Strings.Welcome.inviteButton, for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }
}

extension WelcomeViewController {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            welcomeImage.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 8),
            welcomeImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            welcomeImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / 2),
            welcomeImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 2 / 3),

            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            welcomeLabel.topAnchor.constraint(equalTo: welcomeImage.bottomAnchor, constant: 8),
            
            authorizationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            authorizationLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 32),
            
            entryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            entryButton.topAnchor.constraint(equalTo: authorizationLabel.bottomAnchor, constant: 32),
            entryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            entryButton.heightAnchor.constraint(equalToConstant: 48),
                        
            registrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            registrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            registrationButton.topAnchor.constraint(equalTo: entryButton.bottomAnchor, constant: 16),
            registrationButton.heightAnchor.constraint(equalToConstant: 48),
            
            inviteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            inviteButton.topAnchor.constraint(equalTo: registrationButton.bottomAnchor, constant: 16),
            inviteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            inviteButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}
