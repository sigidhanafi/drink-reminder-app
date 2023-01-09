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
            
            
            self.progressStat?(progressData)
        case let .failure(error):
            print(error)
        }
    }
}
