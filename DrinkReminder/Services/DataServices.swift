//
//  DataServices.swift
//  DrinkReminder
//
//  Created by Sigit Hanafi on 24/12/22.
//

import CoreData
import UIKit

protocol DataServiceProtocol {
    // Target / Goal
    func saveTarget(weight: Double, target: Double)
    func getTarget() -> TargetData
    func resetTarget()
    
    // Progress
    func getProgress() -> Result<ProgressData, DataServiceError>
    func getHistory() -> Result<[ProgressData], DataServiceError>
    func saveProgress(added: Double) -> Result<String, DataServiceError>
    func deleteProgress()
    func resetProgress() -> Result<String, DataServiceError>
}

internal enum DataServiceError: Error {
    case generalError
    case saveDataError
    case getDataError
    
    var description: String {
        switch self {
        case .generalError: return "An internal error happen. Please try again."
        case .getDataError: return "Failed to get data. Please try again."
        case .saveDataError: return "Failed to save data. Please try again."
        }
    }
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
    
    internal func getTarget() -> TargetData {
        let weight = UserDefaults.standard.double(forKey: Constant.hydrateWeightValue)
        let hydrateTargetValue = UserDefaults.standard.double(forKey: Constant.hydrateTargetValue) // in mili liter
        
        return TargetData(target: hydrateTargetValue, weight: weight)
    }
    
    internal func resetTarget() {
        // use user default
        // reset setting data
        UserDefaults.resetDefaults()
    }
    
    internal func getProgress() -> Result<ProgressData, DataServiceError> {
        // get data by today date
        
        // use core data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return .failure(DataServiceError.generalError) }
        
        // get current target
        let target = UserDefaults.standard.double(forKey: Constant.hydrateTargetValue)
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Progress")
        
        var calendar = Calendar.current
        calendar.timeZone = NSTimeZone.local
        
        // get current date
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss:Z"
        dateFormatter.timeZone = calendar.timeZone

        let dateFrom = calendar.startOfDay(for: Date())
        guard let dateTo = calendar.date(byAdding: .day, value: 1, to: dateFrom) else { return .failure(DataServiceError.getDataError) }

//        fetchRequest.predicate = NSPredicate(format: "date >= %@", dateFrom as NSDate)
//        fetchRequest.predicate = NSPredicate(format: "date < %@", dateTo as NSDate)
        
        fetchRequest.predicate = NSPredicate(format: "date >= %@ AND date < %@", dateFrom as NSDate, dateTo as NSDate)
        
        var progress: Double = 0
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            result.forEach { prog in
                progress += prog.value(forKey: "progress") as! Double
            }
            
            return .success(ProgressData(date: Date(), target: target, progress: progress))
        } catch {
            return .failure(DataServiceError.generalError)
        }
        
    }
    
    internal func getHistory() -> Result<[ProgressData], DataServiceError> {
        // get all data
        // use core data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return .failure(.generalError) }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Progress")

        // add sort when fetch request
        let sortByDate = NSSortDescriptor.init(key: "date", ascending: false)
        fetchRequest.sortDescriptors = [sortByDate] // insert in array if want to multiple sort

        do {
            var progressData = [ProgressData]()
            let result = try managedContext.fetch(fetchRequest)
            
            result.forEach { data in
                let date = data.value(forKey: "date") as! Date
                let progress = data.value(forKey: "progress") as! Double
                let target = data.value(forKey: "target") as! Double
                
                progressData.append(ProgressData(date: date, target: target, progress: progress))
            }

            return .success(progressData)
        } catch {
            print("Could not fetch. \(error), \(error.localizedDescription)")
            return .failure(.getDataError)
        }
    }

    internal func saveProgress(added: Double) -> Result<String, DataServiceError> {
        
        // save date, progres value (ml), target value,
        
        // get current target
        let target = UserDefaults.standard.double(forKey: Constant.hydrateTargetValue)
        
        // use core data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return .failure(DataServiceError.generalError) }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let progressEntity = NSEntityDescription.entity(forEntityName: "Progress", in: managedContext)
        
        let insert = NSManagedObject(entity: progressEntity!, insertInto: managedContext)
        insert.setValue(Date(), forKey: "date")
        insert.setValue(added, forKey: "progress")
        insert.setValue(target, forKey: "target")
        
        do {
            try managedContext.save()
            return .success("Progress saved!")
        } catch {
            // print("Could not fetch. \(error), \(error.localizedDescription)")
            return .failure(DataServiceError.saveDataError)
        }
        
    }
    
    internal func deleteProgress() {
        // get data by date and get latest, remove date, progress value (ml), target value
    }
    
    internal func resetProgress() -> Result<String, DataServiceError> {
        // reset all data
        
        // use core data
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return .failure(DataServiceError.generalError) }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let storeCoordinator = appDelegate.persistentContainer.persistentStoreCoordinator
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Progress")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try storeCoordinator.execute(deleteRequest, with: managedContext)
            return .success("Progress reset success")
        } catch {
            // TODO: handle the error
            // print(error.localizedDescription)
            return .failure(DataServiceError.generalError)
        }
    }
}
