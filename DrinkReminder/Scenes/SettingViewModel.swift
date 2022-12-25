//
//  SettingViewModel.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 25/12/22.
//

import Foundation

internal class SettingViewModel {
    
    private let dataService: DataServiceProtocol
    
    internal var weightLabel: ((String) -> Void)?
    internal var targetLabel: ((String) -> Void)?
    
    internal init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
    
    internal func willAppearTrigger() {
        self.updateTargetUI()
    }
    
    internal func reset() {
        self.dataService.reset()
        
        self.updateTargetUI()
    }
    
    internal func saveTarget(weight: Double) {
        self.dataService.saveTarget(weight: weight)
        
        self.updateTargetUI()
    }
    
    private func updateTargetUI() {
        let target = dataService.getTarget()
        
        self.weightLabel?("\(Int(target.weight))")
        
        let targetLabel = target.target > 0 ? "\(target.target / 1000) liters" : "- liter"
        self.targetLabel?(targetLabel)
    }
}
