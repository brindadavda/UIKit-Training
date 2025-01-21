//
//  KeychainProtocol.swift
//  demoKeyChain
//
//  Created by apple on 15/04/24.
//

import UIKit

//MARK :- Protocol for data manupliation
protocol KeychainDelegate{
    func saveData(username : String , password : Data)
    func retriveData(username : String)
    func updateData(username : String , updatedUser : User)
    func deleteUser(username : String)
}
