//
//  Option+CoreDataProperties.swift
//  
//
//  Created by Himanshu on 11/05/18.
//
//

import Foundation
import CoreData


extension Option {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Option> {
        return NSFetchRequest<Option>(entityName: "Option")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var icon: String?

}
