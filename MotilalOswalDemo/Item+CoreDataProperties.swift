//
//  Item+CoreDataProperties.swift
//  MotilalOswalDemo
//
//  Created by yash on 26/09/21.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var content: String?
    @NSManaged public var isDone: Bool
    @NSManaged public var parentCategory: Category?

}

extension Item : Identifiable {

}
