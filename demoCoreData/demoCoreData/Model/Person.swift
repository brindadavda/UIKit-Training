//
//  Person.swift
//  demoCoreData
//
//  Created by apple on 15/02/24.
//

import Foundation

class Person{
    
    let id : UUID!
    let name : String!
    let vehicle : [Vehicle]?
    let email : String?
    
    init(id: UUID!, name: String!, vehicle: [Vehicle]? = nil , email : String? = " " ) {
        self.id = id
        self.name = name
        self.vehicle = vehicle
        self.email = email
    }
    
}
