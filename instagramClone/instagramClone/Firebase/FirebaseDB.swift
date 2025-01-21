//
//  FirebaseDB.swift
//  instagramClone
//
//  Created by apple on 22/02/24.
//

//singloton class

import Foundation
import FirebaseAuth
import FirebaseDatabase // this is firebase realtime database
import FirebaseFirestore

class FirebaseDB {
    static let shared = FirebaseDB()
    private init(){
        debugPrint("FirebaseDB : ---> \(db)")
    }
    private let auth = Auth.auth()
    private let ref = Database.database().reference()
    private let db : Firestore = Firestore.firestore()
    
    func updatePassword(password : String) async -> Bool{
        var isUpdated = false
        
        if let currentUser = auth.currentUser{
            do{
                try await auth.currentUser?.updatePassword(to: password)
                isUpdated = true
            }catch let error{
                debugPrint(error.localizedDescription)
            }
        }
        
        return isUpdated
    }
    
    //register user
    func createUser(email : String , password : String) async -> Bool{
        var isCreated = false
        
        do {
           try await auth.createUser(withEmail: email, password: password)
            isCreated = true
        }
        catch let error{
            debugPrint(error.localizedDescription)
        }
        return isCreated
    }
    
    //login user
    func loginUser(email : String , password : String) async -> Bool {
        var isLogin = false
        do{
            try await auth.signIn(withEmail: email, password: password)
            isLogin = true
                    
        }catch let error{
            debugPrint(error.localizedDescription)
        }
        return isLogin
    }
    
    //add username
    func addData(user : User) async -> Bool{
        var isAdded = false
        //get current user
        if let currentUser = auth.currentUser{
            do{
                if let username = user.getUserName() , let phoneNo = user.getPhoneNumber(){
                    try await ref.child("users").child(currentUser.uid).setValue(["username": username,"phoneNo": phoneNo])
                }
                isAdded = true
            }
            catch let error{
                debugPrint(error)
            }
        }
        
        return isAdded
    }
    
    //update User
    func updateUser(user : User) async -> Bool {
        var isUpdated = false
        
        //update current user password
        if let currentUser = auth.currentUser{
            do{
                if let username = user.getUserName() {
                    try await ref.child("users").child(currentUser.uid).updateChildValues(["username" : username])
                    isUpdated = true
                }
               
            }
            catch let error{
                debugPrint(error)
            }
        }
        
        return isUpdated
    }

    
    func deleteData(user : User) async -> Bool{
        var isDeleted = false
        
        //delete current user data
        if let currentUser = auth.currentUser{
            do{
                try await ref.child("users").child(currentUser.uid).removeValue()
                isDeleted = true
            }
            catch let error{
                debugPrint(error)
            }
        }
        
        return isDeleted
    }
    
}
