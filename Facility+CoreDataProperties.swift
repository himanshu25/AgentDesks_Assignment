//
//  Facility+CoreDataProperties.swift
//  
//
//  Created by Himanshu on 14/05/18.
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
    @NSManaged public var options: NSSet?

}

// MARK: Generated accessors for options
extension Facility {

    @objc(addOptionsObject:)
    @NSManaged public func addToOptions(_ value: Option)

    @objc(removeOptionsObject:)
    @NSManaged public func removeFromOptions(_ value: Option)

    @objc(addOptions:)
    @NSManaged public func addToOptions(_ values: NSSet)

    @objc(removeOptions:)
    @NSManaged public func removeFromOptions(_ values: NSSet)

}
