//
//  EntryViewController.swift
//  test-vacc-rozental
//
//  Created by Alexander Suprun on 22.08.2024.
//

import UIKit

final class EntryViewController: UIViewController {
    private lazy var backButton: UIButton = setupBackButton()
    private lazy var forgotPasswordButton: UIButton = setupForgotPasswordButton()
    private lazy var entryButton: UIButton = setupEntryButton()
    private lazy var usernameTextField: UITextField = setupUsernameTextField()
    private lazy var passwordTextField: UITextField = setupPasswordTextField()
    private lazy var entryLabel: UILabel = setupEntryLabel()
    
    let viewModel: EntryViewModel
    
    init(viewModel: EntryViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        setupMainView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension EntryViewController {
    private func setupMainView() {
        setupLayout()
    }
}

private extension EntryViewController {
    @objc func popView() {
        viewModel.popView()
    }
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        passwordTextField.isSecureTextEntry.toggle()
        sender.isSelected = !sender.isSelected
    }
    
    @objc func goToMainFlow() {
        viewModel.login(username: usernameTextField.text ?? "", password: passwordTextField.text ?? "")
    }
}

private extension EntryViewController {
    func setupBackButton() -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(popView), for: .touchUpInside)
        button.tintColor = .darkGray
        button.backgroundColor = .grayback
        button.layer.cornerRadius = 24
        button.layer.borderColor = UIColor.gray.cgColor
        view.addSubview(button)
        return button
    }
    
    func setupForgotPasswordButton() -> UIButton {
        let button = UIButton()
        button.setTitle(Resources.Strings.Welcome.forgorPassword, for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }
    func setupEntryButton() -> UIButton {
        let button = UIButton()
        button.backgroundColor = .welcomeButton
        button.setTitle(Resources.Strings.Welcome.entry, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(goToMainFlow), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }
    
    func setupUsernameTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.textColor = .black
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 8
        // Placeholder attributes
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "E-mail", attributes: placeholderAttributes)
        
        
        // Left image with padding
        let iconImageView = UIImageView(image: UIImage(systemName: "at"))
        iconImageView.tintColor = .gray
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        let lockImageViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        iconImageView.frame = CGRect(x: 10, y: 0, width: 24, height: 24)
        lockImageViewContainer.addSubview(iconImageView)
        textField.leftView = lockImageViewContainer
        textField.leftViewMode = .always
        
        view.addSubview(textField)
        return textField
    }
    
    func setupPasswordTextField() -> UITextField {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.layer.borderWidth = 1
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.isSecureTextEntry = true
        textField.layer.cornerRadius = 8
        
        // Placeholder attributes
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Пароль", attributes: placeholderAttributes)
        
        // Left image with padding
        let lockImageView = UIImageView(image: UIImage(systemName: "lock")?.withTintColor(.black))
        lockImageView.tintColor = .gray
        lockImageView.contentMode = .scaleAspectFit
        let lockImageViewContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        lockImageView.frame = CGRect(x: 10, y: 0, width: 24, height: 24)
        lockImageViewContainer.addSubview(lockImageView)
        textField.leftView = lockImageViewContainer
        textField.leftViewMode = .always
        
        // Right button with padding
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(UIImage(systemName: "eye.slash")?.withTintColor(.black), for: .normal)
        eyeButton.setImage(UIImage(systemName: "eye")?.withTintColor(.black), for: .selected)
        eyeButton.tintColor = .darkGray
        eyeButton.frame = CGRect(x: 0, y: 0, width: 40, height: 24)
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        let eyeButtonContainer = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 24))
        eyeButtonContainer.addSubview(eyeButton)
        textField.rightView = eyeButtonContainer
        textField.rightViewMode = .always
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        return textField
    }
       
    func setupEntryLabel() -> UILabel {
        let label = UILabel()
        label.text = Resources.Strings.Welcome.entryLabel
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }
}

extension EntryViewController {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 42),
            backButton.heightAnchor.constraint(equalToConstant: 42),
           
            forgotPasswordButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            forgotPasswordButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            
            entryLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 16),
            entryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            entryLabel.heightAnchor.constraint(equalToConstant: 32),
            
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            usernameTextField.topAnchor.constraint(equalTo: entryLabel.bottomAnchor, constant: 32),
            usernameTextField.heightAnchor.constraint(equalToConstant: 48),

            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            passwordTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 24),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
            
            entryButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 32),
            entryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            entryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            entryButton.heightAnchor.constraint(equalToConstant: 64),

        ])
    }
}
