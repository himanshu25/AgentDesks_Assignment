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
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func request() -> NSFetchRequest<NSFetchRequestResult> {
        NSEntityDescription.entity(forEntityName: "Facility", in: getContext())
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Facility")
        request.returnsObjectsAsFaults = false
        return request
    }
    
    func createFacility(dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = getContext()
        if let facilityEntity = NSEntityDescription.insertNewObject(forEntityName: "Facility", into: context) as? Facility {
            facilityEntity.facilityId = dictionary["facility_id"] as? String
            facilityEntity.name = dictionary["name"] as? String
            if let options = dictionary["options"] as? [[String: AnyObject]] {
                for option in options {
                    facilityEntity.addToOptions((createOption(dictionary: option) as! Option))
                }
            }
            return facilityEntity
        }
        return nil
    }
    
    func createOption(dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = getContext()
        if let optionEntity = NSEntityDescription.insertNewObject(forEntityName: "Option", into: context) as? Option {
            optionEntity.id = dictionary["id"] as? String
            optionEntity.name = dictionary["name"] as? String
            optionEntity.icon = dictionary["icon"] as? String
            //            for exclusionObjectarray in  exclusionsArray {
            //                let id = exclusionObjectarray[0]["options_id"] as! String
            //                let excludedId = exclusionObjectarray[1]["options_id"] as! String
            //                if id == optionEntity.id || excludedId == optionEntity.id {
            //                    optionEntity.addToExclusions(optionEntity)
            //                }
            //            }
            return optionEntity
        }
        return nil
    }
}
