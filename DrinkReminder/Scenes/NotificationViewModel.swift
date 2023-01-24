//
//  NotificationViewModel.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 24/01/23.
//

import Foundation
import UserNotifications

internal class NotificationViewModel {
    internal var changeMorningSwitchValue: ((Bool) -> Void)?
    internal var changeAfternoonSwitchValue: ((Bool) -> Void)?
    internal var changeEveningSwitchValue: ((Bool) -> Void)?
    
    init() {
        
    }
    
    internal func didLoadTrigger() {
        let morningSwitchValue = UserDefaults.standard.bool(forKey: "StayHidrateMorningReminder")
        changeMorningSwitchValue?(morningSwitchValue)
        
        let afternoonSwitchValue = UserDefaults.standard.bool(forKey: "StayHidrateAfternoonReminder")
        changeAfternoonSwitchValue?(afternoonSwitchValue)
        
        let eveningSwitchValue = UserDefaults.standard.bool(forKey: "StayHidrateEveningReminder")
        changeEveningSwitchValue?(eveningSwitchValue)
    }
    
    internal func triggerChangeSwitchValue(type: NotificationEventType, currentValue: Bool) {
        if currentValue {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    print("\(type.label) Notification enabled")
                    print("\(type.label) Notification set via button")
    
                    let content = UNMutableNotificationContent()
                    content.title = type.notifTitle
                    content.subtitle = type.notifMessage
                    content.sound = UNNotificationSound.default
    
                    var dateComponent = DateComponents()
                    dateComponent.hour = type.notifHour
                    dateComponent.minute = 00
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
    
                    let request = UNNotificationRequest(identifier: type.identifier, content: content, trigger: trigger)
    
                    UNUserNotificationCenter.current().add(request)
                    
                    UserDefaults.standard.set(true, forKey: type.identifier)
    
                } else {
                    print("Notification denied")
                }
            }
        } else {
            print("\(type.label) Notification disabled")
            print("\(type.label) Notification set via button")
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [type.identifier])
            
            UserDefaults.standard.set(false, forKey: type.identifier)
        }
    }
}
