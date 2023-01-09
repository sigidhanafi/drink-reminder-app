//
//  HistoryViewModel.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 26/12/22.
//

import Foundation

internal class HistoryViewModel {
    private let dataService: DataServiceProtocol
    
    internal var progressStat: (([ProgressStat]) -> Void)?
    
    internal init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
    
    internal func didloadTrigger() {
        let result = self.dataService.getHistory()
        
        switch result {
        case let .success(data):
            
            var progressData = [ProgressStat]()
            
            // mapping data to stat
            for progress in data {
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "dd/MM"
                let date = dateformatter.string(from: progress.date)
                
                if let index = progressData.firstIndex(where: { $0.key == date }) {
                    progressData[index].value += progress.progress
                } else {
                    let stat = ProgressStat(key: date, value: progress.progress)
                    progressData.append(stat)
                }
            }
            
            // get current date
            var calendar = Calendar.current
            calendar.timeZone = NSTimeZone.local
            
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.current
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:Z"
            dateFormatter.timeZone = calendar.timeZone
            
            let tomorrow = calendar.date(byAdding: .day, value: 1, to: Date())!
            let dateTo = calendar.startOfDay(for: tomorrow)
            let dateFrom = calendar.date(byAdding: .day, value: -7, to: dateTo)!
            
            let dayDurationInSeconds: TimeInterval = 60*60*24
            var index = 0
            for date in stride(from: dateFrom, to: dateTo, by: dayDurationInSeconds) {
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "dd/MM"
                let date = dateformatter.string(from: date)

                if !(progressData.contains(where: { $0.key == date })) {
                    progressData.insert(ProgressStat(key: date, value: 0), at: index)
                }
                index += 1
            }
            
            self.progressStat?(progressData)
        case let .failure(error):
            print(error)
        }
    }
}
