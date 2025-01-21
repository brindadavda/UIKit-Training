//
//  Model.swift
//  demoKVC_KVO
//
//  Created by apple on 17/07/24.
//

import Foundation

@objc
class StudentModel : NSObject {
    var id : String
    @objc dynamic var name : String
    @objc dynamic var phoneNumber : Int
    
    init(id: String, name: String, phoneNumber: Int) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
    }
    
    
    
}

@objc
class CombinedObserver: NSObject {
    var observation: NSKeyValueObservation?

    func startObserving(person: StudentModel) -> String?{
            observation = person.observe(\.name) { (_, change) in
                if let newName = change.newValue {
                    onChange(newName)
                }
            }
        
        return nil
        }

    func updateAgeUsingKVC(person: StudentModel, newName: String) {
            person.setValue(newName, forKey: "name")
            print("Updated name using KVC: \(person.name)")
        }
}
