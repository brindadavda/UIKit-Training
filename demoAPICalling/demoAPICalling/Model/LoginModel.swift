//
//  LoginModel.swift
//  demoAPICalling
//
//  Created by apple on 03/02/24.
//

import Foundation

struct Login: Encodable , Decodable {
    let username: String
    let password: String
}


