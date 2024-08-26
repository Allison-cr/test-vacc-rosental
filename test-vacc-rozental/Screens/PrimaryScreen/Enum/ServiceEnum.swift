//
//  Service enum.swift
//  test-vacc-rozental
//
//  Created by Alexander Suprun on 26.08.2024.
//

import UIKit

enum ServiceEnum {
    case camera
    case carrier
    case suggestions
    
    func serviceTitle() -> String {
        switch self {
        case .camera:
            return "Камеры"
        case .carrier:
            return "Шлагбаум"
        case .suggestions:
            return "Преложения"
        }
    }
    
    func serviceImge() -> UIImage {
        switch self {
        case .camera:
            return UIImage(resource: .cameraButton)
        case .carrier:
            return UIImage(resource: .carrierButton)
        case .suggestions:
            return UIImage(resource: .suggestionButton)
        }
    }
}
