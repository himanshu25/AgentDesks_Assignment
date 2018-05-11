//
//  Facility+CoreDataProperties.swift
//  
//
//  Created by Himanshu on 11/05/18.
//
//

import Foundation
import CoreData


extension Facility {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Facility> {
        return NSFetchRequest<Facility>(entityName: "Facility")
    }

    @NSManaged public var facilityId: String?
    @NSManaged public var name: String?

}
