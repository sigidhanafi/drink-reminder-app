//
//  HistoryViewModel.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 26/12/22.
//

import Foundation

internal class HistoryViewModel {
    private let dataService: DataServiceProtocol
    
    internal var progressData: (([ProgressData]) -> Void)?
    
    internal init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
    
    internal func didloadTrigger() {
        let result = self.dataService.getHistory()
        
        switch result {
        case let .success(data):
            self.progressData?(data)
        case let .failure(error):
            print(error)
        }
    }
}
