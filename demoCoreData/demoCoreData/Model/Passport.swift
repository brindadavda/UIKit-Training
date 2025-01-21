//
//  Passport.swift
//  demoCoreData
//
//  Created by apple on 14/02/24.
//

import Foundation

class Passport
{
    let id: UUID
    let passportId , placeOfIssue , name : String?
    
    init(_id : UUID , _passportId : String? , _placeOfIssue : String? , _name : String? = nil){
        self.id = _id
        self.passportId = _passportId
        self.placeOfIssue = _placeOfIssue
        self.name = _name
    }
}
