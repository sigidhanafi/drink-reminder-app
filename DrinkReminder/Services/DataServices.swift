//
//  DataServices.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 24/12/22.
//

import Foundation

protocol DataServiceProtocol {
    func saveTarget(weight: Double, target: Double)
    func getTarget() -> Target
    func getProgress() -> Progress
    func getHistory()
    func saveProgress(added: Double)
    func deleteProgress()
    func reset()
}

final class DataServices: DataServiceProtocol {
    
    internal func saveTarget(weight: Double, target: Double) {
        // save weight
        // save target value
        
        // set hydrate value in mili liter
        UserDefaults.standard.set(target, forKey: Constant.hydrateTargetValue)
        
        // set weight in user default in int
        UserDefaults.standard.set(weight, forKey: Constant.hydrateWeightValue)
    }
    
    internal func getTarget() -> Target {
        let weight = UserDefaults.standard.double(forKey: Constant.hydrateWeightValue)
        let hydrateTargetValue = UserDefaults.standard.double(forKey: Constant.hydrateTargetValue) // in mili liter
        
        return Target(target: hydrateTargetValue, weight: weight)
    }
    
    internal func getProgress() -> Progress {
        // get data by today date
        let hydrateTargetValue: Double = UserDefaults.standard.double(forKey: Constant.hydrateTargetValue)
        let hydrateProgressValue: Double = UserDefaults.standard.double(forKey: Constant.hydrateProgressValue)
        
        return Progress(target: hydrateTargetValue, progress: hydrateProgressValue)
    }
    
    internal func getHistory() {
        // get all data
    }
    
    internal func saveProgress(added: Double) {
        // save date, progres value (ml), target value,
        let currentProgress = UserDefaults.standard.double(forKey: Constant.hydrateProgressValue)
        
        UserDefaults.standard.set(currentProgress + added, forKey: Constant.hydrateProgressValue)
    }
    
    internal func deleteProgress() {
        // get data by date and get latest, remove date, progress value (ml), target value
    }
    
    internal func reset() {
        // reset all data
        UserDefaults.resetDefaults()
    }
}
