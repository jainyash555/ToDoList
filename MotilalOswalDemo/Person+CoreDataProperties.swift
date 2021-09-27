//
//  Person+CoreDataProperties.swift
//  MotilalOswalDemo
//
//  Created by yash on 26/09/21.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var city: String?
    @NSManaged public var parent: NSSet?

}

// MARK: Generated accessors for parent
extension Person {

    @objc(addParentObject:)
    @NSManaged public func addToParent(_ value: Category)

    @objc(removeParentObject:)
    @NSManaged public func removeFromParent(_ value: Category)

    @objc(addParent:)
    @NSManaged public func addToParent(_ values: NSSet)

    @objc(removeParent:)
    @NSManaged public func removeFromParent(_ values: NSSet)

}

extension Person : Identifiable {

}
