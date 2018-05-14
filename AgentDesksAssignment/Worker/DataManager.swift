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
}
