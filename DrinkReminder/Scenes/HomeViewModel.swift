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
    
    private func updateUI() {
        let progress = dataService.getProgress()
        
        switch progress {
        case let .success(data):
            let percentage = ((data.progress / data.target) * 100) / 100
            
            // update UI target label
            let targetLabel = "\(data.target / 1000) liters"
            self.targetLabel?(targetLabel)
            
            self.progressPercentage?(CGFloat(percentage))
        case let .failure(error):
            print(error.description)
        }
    }
    
    internal func willAppearTrigger() {
        self.updateUI()
    }
    
    internal func saveProgress(added: Double) {
        let result = dataService.saveProgress(added: added)
        switch result {
        case let .success(message):
            self.updateUI()
            print(message)
        case let .failure(error):
            print(error)
        }
    }
    
    internal func btnDrink1Trigger() {
        // 240ml
        // save the progress in mili liter
        self.saveProgress(added: 240)
    }
    
    internal func btnDrink2Trigger() {
        // 325ml
        // save the progress in mili liter
        self.saveProgress(added: 325)
    }
    
    internal func btnDrink3Trigger() {
        // 600ml
        // save the progress in mili liter
        self.saveProgress(added: 600)
    }
    
    internal func btnDrink4Trigger() {
        // 1200ml
        // save the progress in mili liter
        self.saveProgress(added: 1200)
    }
    
}
