//
//  CustomView.swift
//  test-vacc-rozental
//
//  Created by Alexander Suprun on 23.08.2024.
//

import Foundation
import UIKit

class CustomView: UIView {
    
    private let leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    init(leftImage: UIImage?, title: String, subtitle: String, textRightLabel: String?) {
        super.init(frame: .zero)
        leftImageView.image = leftImage
        titleLabel.text = title
        subtitleLabel.text = subtitle
        updateRightLabel(textRightLabel: textRightLabel)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func updateRightLabel(textRightLabel: String?) {
        if let text = textRightLabel, !text.isEmpty {
            let components = text.split(separator: ".")
            let integerPart = String(components.first ?? "")
            let decimalPart = components.count > 1 ? String(components.last ?? "") : ""
            
            let attributedString = NSMutableAttributedString()
            
            let integerAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 18, weight: .bold),
                .foregroundColor: UIColor.black
            ]
            let integerAttributedString = NSAttributedString(string: integerPart, attributes: integerAttributes)
            attributedString.append(integerAttributedString)
            
            if !decimalPart.isEmpty {
                let decimalAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 18, weight: .bold),
                    .foregroundColor: UIColor.gray
                ]
                let decimalAttributedString = NSAttributedString(string: ".\(decimalPart)", attributes: decimalAttributes)
                attributedString.append(decimalAttributedString)
            }
            
            rightLabel.attributedText = attributedString
        } else {
            let attachment = NSTextAttachment()
            attachment.image = UIImage(systemName: "drop.fill")
            let attributedString = NSAttributedString(attachment: attachment)
            rightLabel.attributedText = attributedString
        }
    }
}

private extension CustomView {
    func setupView() {
        addSubview(leftImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(rightLabel)
        
        NSLayoutConstraint.activate([
            
            self.heightAnchor.constraint(equalToConstant: 60),
            self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            
            leftImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            leftImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            leftImageView.widthAnchor.constraint(equalToConstant: 60),
            leftImageView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.leadingAnchor.constraint(equalTo: leftImageView.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            
            rightLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            rightLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            rightLabel.leadingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor,constant: 8)
        ])
    }
}
