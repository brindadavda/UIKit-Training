//
//  CDProduct+CoreDataProperties.swift
//  demoCoreDataHeavyWeightMigration
//
//  Created by apple on 16/02/24.
//
//

import Foundation
import CoreData


extension CDProduct {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDProduct> {
        return NSFetchRequest<CDProduct>(entityName: "CDProduct")
    }

    @NSManaged public var expiryDate: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var manufactureDate: Date?
    @NSManaged public var name: String?
    @NSManaged public var price: NSDecimalNumber?

}

extension CDProduct : Identifiable {

}
