//
//  Option+CoreDataProperties.swift
//  AgentDesksAssignment
//
//  Created by Himanshu on 14/05/18.
//  Copyright © 2018 Himanshu. All rights reserved.
//
//

import Foundation
import CoreData


extension Option {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Option> {
        return NSFetchRequest<Option>(entityName: "Option")
    }

    @NSManaged public var icon: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var exclusions: NSSet?

}

// MARK: Generated accessors for exclusions
extension Option {

    @objc(addExclusionsObject:)
    @NSManaged public func addToExclusions(_ value: Option)

    @objc(removeExclusionsObject:)
    @NSManaged public func removeFromExclusions(_ value: Option)

    @objc(addExclusions:)
    @NSManaged public func addToExclusions(_ values: NSSet)

    @objc(removeExclusions:)
    @NSManaged public func removeFromExclusions(_ values: NSSet)

}
