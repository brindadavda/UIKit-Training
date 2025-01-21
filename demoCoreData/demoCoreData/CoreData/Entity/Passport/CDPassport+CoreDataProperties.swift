//
//  CDPassport+CoreDataProperties.swift
//  demoCoreData
//
//  Created by apple on 14/02/24.
//
//

import Foundation
import CoreData


extension CDPassport {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPassport> {
        return NSFetchRequest<CDPassport>(entityName: "CDPassport")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var passprtID: String?
    @NSManaged public var placeofIssue: String?
    @NSManaged public var toEmployee: CDEmployee?

}

extension CDPassport : Identifiable {
    func convertToPassport() -> Passport{
        return Passport(_id: self.id!, _passportId: self.passprtID!, _placeOfIssue: self.placeofIssue!, _name: self.toEmployee?.name)
        
    }
}
