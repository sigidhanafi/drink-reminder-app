//
//  Date+Strideable.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 10/01/23.
//

import Foundation

extension Date: Strideable {
    public func distance(to other: Date) -> TimeInterval {
        return other.timeIntervalSinceReferenceDate - self.timeIntervalSinceReferenceDate
    }

    public func advanced(by n: TimeInterval) -> Date {
        return self + n
    }
}
