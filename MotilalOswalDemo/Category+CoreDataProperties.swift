//
//  Category+CoreDataProperties.swift
//  MotilalOswalDemo
//
//  Created by yash on 26/09/21.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var name: String?
    @NSManaged public var items: Item?

}

extension Category : Identifiable {

}
