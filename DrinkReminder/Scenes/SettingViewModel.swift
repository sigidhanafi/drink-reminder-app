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
    internal var errorWeightMessage: ((String) -> Void)?
    
    internal init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }
    
    internal func willAppearTrigger() {
        self.updateTargetUI()
    }
    
    internal func reset() {
        let result = self.dataService.resetProgress()
        
        switch result {
        case let .failure(error):
            print(error.description)
        case let .success(message):
            print(message)
            self.dataService.resetTarget()
            self.updateTargetUI()
        }
    }
    
    internal func saveTarget(weightString: String?) {
        
        guard let newWeightString = weightString,
              newWeightString != "",
              let weightDouble = Double(newWeightString),
              weightDouble >= 0,
              weightDouble <= 300
        else {
            self.errorWeightMessage?("Weight is invalid. Please try again.")
            return
        }
        
        // calculate target based on weight
        var targetValue: Double = 0
        if weightDouble >= 20 {
            // the first 10kg => 1000 ml
            // the second 10kg => 500 ml
            targetValue += 1500
        }
        
        let restOfWeight = weightDouble - 20
        if restOfWeight > 0 {
            // the rest kg * 20ml for each kg
            targetValue += restOfWeight * 20
        }
        
        targetValue = ceil(targetValue * 100) / 100
        
        self.dataService.saveTarget(weight: weightDouble, target: targetValue)
        
        self.updateTargetUI()
    }
    
    private func updateTargetUI() {
        let target = dataService.getTarget()
        
        self.weightLabel?("\(Int(target.weight))")
        
        let targetLabel = target.target > 0 ? "\(target.target / 1000) liters" : "- liter"
        self.targetLabel?(targetLabel)
    }
}
