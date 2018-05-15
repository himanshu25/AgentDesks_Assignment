//
//  DataManager.swift
//  AgentDesksAssignment
//
//  Created by Himanshu on 14/05/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataManager: NSObject {
    static let sharedInstance = DataManager()
    var exclusionsArray =  [[[String: AnyObject]]]()

    func getContext () -> NSManagedObjectContext {
        return CoreDataStack.sharedInstance.persistentContainer.viewContext
    }
    
    func request() -> NSFetchRequest<NSFetchRequestResult> {
        NSEntityDescription.entity(forEntityName: "Facility", in: getContext())
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Facility")
        request.returnsObjectsAsFaults = false
        return request
    }
    
    func createFacility(dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = getContext()
        if let facility = NSEntityDescription.insertNewObject(forEntityName: "Facility", into: context) as? Facility {
            facility.facilityId = dictionary["facility_id"] as? String
            facility.name = dictionary["name"] as? String
            if let options = dictionary["options"] as? [[String: AnyObject]] {
                for option in options {
                    facility.addToOptions((createOption(dictionary: option) as! Option))
                    }
                }
            return facility
        }
        return nil
    }
    
    func createOption(dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = getContext()
        if let option = NSEntityDescription.insertNewObject(forEntityName: "Option", into: context) as? Option {
            option.id = dictionary["id"] as? String
            option.name = dictionary["name"] as? String
            option.icon = dictionary["icon"] as? String
            return option
        }
        return nil
    }
    
    func createExclusion(dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = getContext()
        if let option = NSEntityDescription.insertNewObject(forEntityName: "Option", into: context) as? Option {
            option.id = dictionary["options_id"] as? String
            return option
        }
        return nil
    }
    
    func saveFacilityInCoreDataWith(array: [[String: AnyObject]]) {
        _ = array.map{createFacility(dictionary: $0)}
        do {
            try CoreDataStack.sharedInstance.persistentContainer.viewContext.save()
        } catch let error {
            print(error)
        }
    }
}
