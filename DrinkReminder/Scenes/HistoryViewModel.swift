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
            
            var progressData: [String: Double] = [:]
            
            for progress in data {
                let dateformatter = DateFormatter()
                dateformatter.dateFormat = "dd/MM"
                let date = dateformatter.string(from: progress.date)
                
                progressData[date] = (progressData[date] ?? 0) + progress.progress
            }
            
            var stats = [ProgressStat]()
            
            for (key, value) in progressData {
                let stat = ProgressStat(key: key, value: value)
                stats.append(stat)
            }
            
            
            self.progressStat?(stats)
        case let .failure(error):
            print(error)
        }
    }
}
