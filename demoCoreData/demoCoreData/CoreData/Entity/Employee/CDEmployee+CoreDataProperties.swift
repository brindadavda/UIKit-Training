//
//  CDEmployee+CoreDataProperties.swift
//  demoCoreData
//
//  Created by apple on 14/02/24.
//
//

import Foundation
import CoreData


extension CDEmployee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEmployee> {
        return NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var profilePic: Data?
    @NSManaged public var toPassprt: CDPassport?

}

extension CDEmployee : Identifiable {
    func convertToEmployee() -> Employee{
        return Employee(_name: self.name!, _email: self.email!, _profilePic: self.profilePic!, _id: self.id!, _passport: self.toPassprt?.convertToPassport())
    }
}
