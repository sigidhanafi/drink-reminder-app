//
//  HomeViewModel.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 24/12/22.
//

import Foundation

class HomeViewModel {
    private let dataService: DataServiceProtocol
    
    internal var targetLabel: ((String) -> Void)?
    internal var progressPercentage: ((CGFloat) -> Void)?
    
    init(dataService: DataServices) {
        self.dataService = dataService
    }
    
    internal func didLoadTrigger() {
        let progress = dataService.getProgress()
        let percentage = ((progress.progress / progress.target) * 100) / 100
        
        // update UI target label
        let targetLabel = "\(progress.target / 1000) liters"
        self.targetLabel?(targetLabel)
        
        self.progressPercentage?(CGFloat(percentage))
    }
    
    internal func willAppearTrigger() {
        let progress = dataService.getProgress()
        let percentage = ((progress.progress / progress.target) * 100) / 100
        
        // update UI target label
        let targetLabel = "\(progress.target / 1000) liters"
        self.targetLabel?(targetLabel)
        
        self.progressPercentage?(CGFloat(percentage))
    }
    
    internal func saveProgress(added: Double) {
        dataService.saveProgress(added: added)
        
        let progress = dataService.getProgress()
        let percentage = ((progress.progress / progress.target) * 100) / 100
        
        // update UI target label
        let targetLabel = "\(progress.target / 1000) liters"
        self.targetLabel?(targetLabel)
        
        self.progressPercentage?(CGFloat(percentage))
    }
    
}
