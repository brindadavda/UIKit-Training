//
//  CDVehicle+CoreDataProperties.swift
//  demoCoreData
//
//  Created by apple on 15/02/24.
//
//

import Foundation
import CoreData


extension CDVehicle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDVehicle> {
        return NSFetchRequest<CDVehicle>(entityName: "CDVehicle")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var brand: String?
    @NSManaged public var type: String?
    @NSManaged public var toPerson: CDPerson?

}

extension CDVehicle : Identifiable {
    func convertToVehicle() -> Vehicle{
        return Vehicle(id: self.id, name: self.brand, type: self.type, toPerson: self.toPerson)
    }
}
