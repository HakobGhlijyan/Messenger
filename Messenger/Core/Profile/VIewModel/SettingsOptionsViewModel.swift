//
//  SettingsOptionsViewModel.swift
//  Messenger
//
//  Created by Hakob Ghlijyan on 28.10.2024.
//

import SwiftUI

enum SettingsOptionsViewModel: Int, Identifiable, CaseIterable {
    case darkMode
    case activeStatus
    case accessibility
    case privacy
    case notifications

    var id: Int { rawValue }
    
    var title: String {
        switch self {
        case .darkMode: return "Dark Mode"
        case .activeStatus: return "Active Status"
        case .accessibility: return "Accessibility"
        case .privacy: return "Privacy and Safety"
        case .notifications: return "Notifications"
        }
    }
    
    var imageName: String {
        switch self {
        case .darkMode: return "moon.stars.fill"
        case .activeStatus: return "message.badge.circle.fill"
        case .accessibility: return "person.circle.fill"
        case .privacy: return "lock.circle.fill"
        case .notifications: return "bell.circle.fill"
        }
    }
    
    var imageBackgroundColor: Color {
        switch self {
        case .darkMode: return .primary
        case .activeStatus: return .green
        case .accessibility: return .secondary
        case .privacy: return .blue
        case .notifications: return .purple
        }
    }
    
}
