//
//  TabBarPage.swift
//  test-vacc-rozental
//
//  Created by Alexander Suprun on 22.08.2024.
//

import Foundation
import UIKit

enum TabbarPage {
    case primary
    case request
    case services
    case chat
    case contacts
    
    func pageTitleValue() -> String {
        switch self {
        case .primary:
            return "Главная"
        case .request:
            return "Заявки"
        case .services:
            return "Услуги"
        case .chat:
            return "Чат"
        case .contacts:
            return "Контакты"
        }
    }
    
    func pageIconValue() -> UIImage {
        switch self {
        case .primary:
            return UIImage(systemName: "plus")!
        case .request:
            return UIImage(systemName: "plus")!
        case .services:
            return UIImage(systemName: "plus")!
        case .chat:
            return UIImage(systemName: "plus")!
        case .contacts:
            return UIImage(systemName: "plus")!
        }
    }
    
    static let allTabbarPages: [TabbarPage] = [.primary, .request, .services, .chat, .contacts]
    static let firstTabbarPage: TabbarPage = .primary
    
    var pageOrderNumber: Int {
        guard let num = TabbarPage.allTabbarPages.firstIndex(of: self) else { return .zero }
        return num
    }
}
