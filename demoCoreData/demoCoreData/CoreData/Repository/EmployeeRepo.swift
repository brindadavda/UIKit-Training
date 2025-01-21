//
//  EmployeeRepo.swift
//  demoCoreData
//
//  Created by apple on 02/02/24.
//

import Foundation
import CoreData


protocol EmployeeRepository : BaseRepository{
    //if additional procol you want to add
}

//create structure for repository
struct EmployeeDataRepository : EmployeeRepository {
    
    func create(record employee: Employee) {
        let cdEmployee = CDEmployee(context: PersistentStorage.shared.context)
        cdEmployee.name = employee.name
        cdEmployee.email = employee.email
        cdEmployee.id = employee.id
        cdEmployee.profilePic = employee.profilePic
        
        if let passport = employee.passport {
            let cdPassport = CDPassport(context: PersistentStorage.shared.context)
            cdPassport.placeofIssue = passport.placeOfIssue
            cdPassport.passprtID = passport.passportId
            cdPassport.id = passport.id
            
            cdEmployee.toPassprt = cdPassport
        }
        
        PersistentStorage.shared.saveContext()
    }
    
    func get(fromId id: UUID) -> Employee? {
        //fetch entity
        let result = getDataFromID(byIdentifier: id, entity: "CDEmployee") as? CDEmployee
        guard result != nil else{return nil}
        
        return result?.convertToEmployee()
    }
    
    func getAll() -> [Employee]? {
        let result = PersistentStorage.shared.fetchManageObject(manageObject: CDEmployee.self)
        
        var employee = [Employee]()

        result?.forEach({ cdEmployee in
            employee.append(cdEmployee.convertToEmployee())
        })
            
        return employee
    }
    
    func update(record employee: Employee) -> Bool {
        let cdEmployee = getDataFromID(byIdentifier: employee.id, entity: "CDEmployee") as? CDEmployee
        guard cdEmployee != nil else{return false}
        
        cdEmployee?.email = employee.email
        cdEmployee?.name = employee.name
        cdEmployee?.profilePic = employee.profilePic
        
        if let passport = employee.passport {
            let cdPassport = getDataFromID(byIdentifier: passport.id, entity: "CDPassport") as? CDPassport
            cdPassport?.placeofIssue = passport.placeOfIssue
            cdPassport?.passprtID = passport.passportId
            cdPassport?.id = passport.id
            
            cdEmployee?.toPassprt = cdPassport
        }
        
        PersistentStorage.shared.saveContext()
        return true
    }
    
    func delete(record employee: Employee) -> Bool{
        let cdEmployee = getDataFromID(byIdentifier: employee.id, entity: "CDEmployee") as? CDEmployee
        guard cdEmployee != nil else{return false}
        
        if let cdPassport = cdEmployee?.toPassprt{
           PersistentStorage.shared.context.delete(cdPassport)
        }
        PersistentStorage.shared.context.delete(cdEmployee!)
        PersistentStorage.shared.saveContext()
        return true
    }
    
    
    
}
