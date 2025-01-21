//
//  Employee.swift
//  demoCoreData
//
//  Created by apple on 02/02/24.
//

import Foundation

class Employee
{
    let name, email : String
    let profilePic: Data
    let id: UUID
    var passport : Passport?
    
    init(_name: String, _email: String, _profilePic: Data, _id: UUID, _passport: Passport? = nil) {
        self.name = _name
        self.email = _email
        self.profilePic = _profilePic
        self.id = _id
        self.passport = _passport
    }
    
}
