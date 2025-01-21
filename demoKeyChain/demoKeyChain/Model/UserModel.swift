//
//  UserModel.swift
//  demoKeyChain
//
//  Created by apple on 15/04/24.
//

import Foundation

class User : Decodable{
    let id : UUID
    var username : String
    var password : Data
    
    init(id: UUID, username: String, password: Data) {
        self.id = id
        self.username = username
        self.password = password
    }
}
