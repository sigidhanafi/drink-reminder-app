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
        
        // calculate target based on weight
        var targetValue: Double = 0
        if weight >= 20 {
            // the first 10kg => 1000 ml
            // the second 10kg => 500 ml
            targetValue += 1500
        }
        
        let restOfWeight = weight - 20
        if restOfWeight > 0 {
            // the rest kg * 20ml for each kg
            targetValue += restOfWeight * 20
        }
        
        targetValue = ceil(targetValue * 100) / 100
        
        self.dataService.saveTarget(weight: weight, target: targetValue)
        
        self.updateTargetUI()
    }
    
    private func updateTargetUI() {
        let target = dataService.getTarget()
        
        self.weightLabel?("\(Int(target.weight))")
        
        let targetLabel = target.target > 0 ? "\(target.target / 1000) liters" : "- liter"
        self.targetLabel?(targetLabel)
    }
}
