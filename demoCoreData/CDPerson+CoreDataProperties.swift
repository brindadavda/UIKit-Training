//
//  CDPerson+CoreDataProperties.swift
//  demoCoreData
//
//  Created by apple on 15/02/24.
//
//

import Foundation
import CoreData


extension CDPerson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPerson> {
        return NSFetchRequest<CDPerson>(entityName: "CDPerson")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var toVehicle: Set<CDVehicle>?

}

// MARK: Generated accessors for toVehicle
extension CDPerson {

    @objc(addToVehicleObject:)
    @NSManaged public func addToToVehicle(_ value: CDVehicle)

    @objc(removeToVehicleObject:)
    @NSManaged public func removeFromToVehicle(_ value: CDVehicle)

    @objc(addToVehicle:)
    @NSManaged public func addToToVehicle(_ values: NSSet)

    @objc(removeToVehicle:)
    @NSManaged public func removeFromToVehicle(_ values: NSSet)

}

extension CDPerson : Identifiable {
    func convertToPerson() -> Person{
        return Person(id: self.id, name: self.name, vehicle: self.convertToVehicles() , email: self.email)
    }
    
    func convertToVehicles() -> [Vehicle]?{
        
        guard (self.toVehicle != nil && self.toVehicle?.count != 0 ) else {return []}
        
        var vehicle : [Vehicle] = []
        
        self.toVehicle?.forEach({
            cdVehicle in
            vehicle.append(Vehicle(id: cdVehicle.id, name: cdVehicle.brand, type: cdVehicle.type))
        })
        
        
        
        return vehicle
    }
}
