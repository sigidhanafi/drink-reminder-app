//
//  NotificationViewController.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 02/01/23.
//

import UIKit

class NotificationViewController: UIViewController {
    
    private let contentStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let morningStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let morningLabel: UILabel = {
        let label = UILabel()
        label.text = "Morning"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .primaryBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let morningSwitch: UISwitch = {
        let view = UISwitch()
        view.isOn = UserDefaults.standard.bool(forKey: "StayHidrateMorningReminder")
        view.isEnabled = true
        
        return view
    }()
    
    private let afternoonStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let afternoonLabel: UILabel = {
        let label = UILabel()
        label.text = "Afternoon"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .primaryBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let afternoonSwitch: UISwitch = {
        let view = UISwitch()
        view.isOn = UserDefaults.standard.bool(forKey: "StayHidrateAfternoonReminder")
        view.isEnabled = true
        
        return view
    }()
    
    private let eveningStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let eveningLabel: UILabel = {
        let label = UILabel()
        label.text = "Evening"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .primaryBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let eveningSwitch: UISwitch = {
        let view = UISwitch()
        view.isOn = UserDefaults.standard.bool(forKey: "StayHidrateEveningReminder")
        view.isEnabled = true
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notification"
        
        view.backgroundColor = .white
        
        morningStackView.addArrangedSubview(morningLabel)
        morningStackView.addArrangedSubview(morningSwitch)
        contentStackView.addArrangedSubview(morningStackView)
        
        afternoonStackView.addArrangedSubview(afternoonLabel)
        afternoonStackView.addArrangedSubview(afternoonSwitch)
        contentStackView.addArrangedSubview(afternoonStackView)
        
        
        eveningStackView.addArrangedSubview(eveningLabel)
        eveningStackView.addArrangedSubview(eveningSwitch)
        contentStackView.addArrangedSubview(eveningStackView)
        
        view.addSubview(contentStackView)
        
        morningSwitch.addTarget(self, action: #selector(morningSwitchHandler), for: .valueChanged)
        afternoonSwitch.addTarget(self, action: #selector(afternoonSwitchHandler), for: .valueChanged)
        eveningSwitch.addTarget(self, action: #selector(eveningSwitchHandler), for: .valueChanged)
        
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            contentStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 16),
            contentStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16)
        ])
        
    }
    
    @objc private func morningSwitchHandler(_ sender: UISwitch) {
        if sender.isOn {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    print("Morning Notification enabled")
                    print("Morning Notification set via button")
    
                    let content = UNMutableNotificationContent()
                    content.title = "Good Morning!"
                    content.subtitle = "Start your day with drink. Stay hydrate!"
                    content.sound = UNNotificationSound.default
    
                    var dateComponent = DateComponents()
                    dateComponent.hour = 8
                    dateComponent.minute = 00
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
                    // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
    
                    let request = UNNotificationRequest(identifier: "StayHidrateMorningReminder", content: content, trigger: trigger)
    
                    UNUserNotificationCenter.current().add(request)
                    
                    UserDefaults.standard.set(true, forKey: "StayHidrateMorningReminder")
    
                } else {
                    print("Notification denied")
                }
            }
        } else {
            print("Morning Notification disabled")
            print("Morning Notification set via button")
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["StayHidrateMorningReminder"])
            
            UserDefaults.standard.set(false, forKey: "StayHidrateMorningReminder")
        }
    }
    
    @objc private func afternoonSwitchHandler(_ sender: UISwitch) {
        if sender.isOn {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    print("Afternoon Notification authorized")
                    print("Afternoon Notification set via button")
    
                    let content = UNMutableNotificationContent()
                    content.title = "Good Afternoon!"
                    content.subtitle = "You at your half day. Stay hydrate!"
                    content.sound = UNNotificationSound.default
    
                    var dateComponent = DateComponents()
                    dateComponent.hour = 12
                    dateComponent.minute = 00
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
                    // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
    
                    let request = UNNotificationRequest(identifier: "StayHidrateAfternoonReminder", content: content, trigger: trigger)
    
                    UNUserNotificationCenter.current().add(request)
                    
                    UserDefaults.standard.set(true, forKey: "StayHidrateAfternoonReminder")
    
                } else {
                    print("Notification denied")
                }
            }
        } else {
            print("Afternoon Notification disabled")
            print("Afternoon Notification set via button")
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["StayHidrateAfternoonReminder"])
            
            UserDefaults.standard.set(false, forKey: "StayHidrateAfternoonReminder")
        }
    }
    
    @objc private func eveningSwitchHandler(_ sender: UISwitch) {
        if sender.isOn {
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    print("Evening Notification enabled")
                    print("Evening Notification set via button")
    
                    let content = UNMutableNotificationContent()
                    content.title = "Good Evening!"
                    content.subtitle = "Your day almost end. Stay hydrate!"
                    content.sound = UNNotificationSound.default
    
                    var dateComponent = DateComponents()
                    dateComponent.hour = 16
                    dateComponent.minute = 00
                    let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
                    // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
    
                    let request = UNNotificationRequest(identifier: "StayHidrateEveningReminder", content: content, trigger: trigger)
    
                    UNUserNotificationCenter.current().add(request)
                    
                    UserDefaults.standard.set(true, forKey: "StayHidrateEveningReminder")
    
                } else {
                    print("Notification denied")
                }
            }
        } else {
            print("Evening Notification disabled")
            print("Evening Notification set via button")
            
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["StayHidrateEveningReminder"])
            
            UserDefaults.standard.set(false, forKey: "StayHidrateEveningReminder")
        }
    }
}
