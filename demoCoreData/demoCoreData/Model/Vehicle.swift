//
//  Vehicle.swift
//  demoCoreData
//
//  Created by apple on 15/02/24.
//

import Foundation

class Vehicle{
    let id : UUID!
    let name : String!
    let type : String!
    let brand : String?
    let toPerson : CDPerson?
    
    init(id: UUID!, name: String!, type: String!, toPerson: CDPerson? = nil , brand : String? = " ") {
        self.id = id
        self.name = name
        self.type = type
        self.toPerson = toPerson
        self.brand = brand
    }
}
