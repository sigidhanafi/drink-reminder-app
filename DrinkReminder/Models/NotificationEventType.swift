//
//  NotificationEventType.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 24/01/23.
//

enum NotificationEventType {
    case morning
    case afternoon
    case evening
    
    var id: Int {
        switch self {
            case .morning: return 1
            case .afternoon: return 2
            case .evening: return 3
        }
    }
    
    var identifier: String {
        switch self {
            case .morning: return "StayHidrateMorningReminder"
            case .afternoon: return "StayHidrateAfternoonReminder"
            case .evening: return "StayHidrateEveningReminder"
        }
    }
    
    var label: String {
        switch self {
            case .morning: return "Morning"
            case .afternoon: return "Afternoon"
            case .evening: return "Evening"
        }
    }
    
    var notifTitle: String {
        switch self {
            case .morning: return "Good Morning!"
            case .afternoon: return "Good Afternoon!"
            case .evening: return "GoodEvening!"
        }
    }
    
    var notifMessage: String {
        switch self {
        case .morning: return "Start your day with drink. Stay hydrate!"
        case .afternoon: return "You at your half day. Stay hydrate!"
        case .evening: return "Your day almost end. Stay hydrate!"
        }
    }
    
    var notifHour: Int {
        switch self {
        case .morning: return 8
        case .afternoon: return 12
        case .evening: return 16
        }
    }
}
