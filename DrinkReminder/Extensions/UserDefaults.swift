//
//  UserDefault.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 23/12/22.
//

import Foundation

extension UserDefaults {
    static func resetDefaults() {
        if let bundleID = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleID)
        }
    }
}
