//
//  User.swift
//  instagramClone
//
//  Created by apple on 22/02/24.
//

import Foundation

class User{
    private let username : String?
    private let phoneNumber : String?
    
    init(username: String? , phoneNumber : String?) {
        self.username = username
        self.phoneNumber = phoneNumber
    }
    
    func getUserName() -> String?{
        return self.username
    }
    
    func getPhoneNumber() -> String?{
        return self.phoneNumber
    }
    
}
