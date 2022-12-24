//
//  DataServices.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 24/12/22.
//

import Foundation

struct DataServices {
    
    static internal func saveTarget(weight: Double) {
        // save weight
        // save target value
        
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
        
        // set hydrate value in mili liter
        UserDefaults.standard.set(targetValue, forKey: Constant.hydrateTargetValue)
        
        // set weight in user default in int
        UserDefaults.standard.set(weight, forKey: Constant.hydrateWeightValue)
    }
    
    static internal func getTarget() -> Target {
        let weight = UserDefaults.standard.integer(forKey: Constant.hydrateWeightValue)
        let hydrateTargetValue = UserDefaults.standard.double(forKey: Constant.hydrateTargetValue) // in mili liter
        
        return Target(target: hydrateTargetValue, weight: weight)
    }
    
    static internal func getProgress() -> Progress {
        // get data by today date
        let hydrateTargetValue: Double = UserDefaults.standard.double(forKey: Constant.hydrateTargetValue)
        let hydrateProgressValue: Double = UserDefaults.standard.double(forKey: Constant.hydrateProgressValue)
        
        return Progress(target: hydrateTargetValue, progress: hydrateProgressValue)
    }
    
    static internal func getHistory() {
        // get all data
    }
    
    static internal func saveProgress(added: Double) {
        // save date, progres value (ml), target value,
        let currentProgress = UserDefaults.standard.double(forKey: Constant.hydrateProgressValue)
        
        UserDefaults.standard.set(currentProgress + added, forKey: Constant.hydrateProgressValue)
    }
    
    static internal func deleteProgress() {
        // get data by date and get latest, remove date, progress value (ml), target value
    }
    
    static internal func reset() {
        // reset all data
        UserDefaults.resetDefaults()
    }
}
