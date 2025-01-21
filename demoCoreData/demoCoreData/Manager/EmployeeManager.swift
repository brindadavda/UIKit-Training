//
//  EmployeeManager.swift
//  demoCoreData
//
//  Created by apple on 13/02/24.
//

import Foundation
import CoreData

protocol CrudOperationForManager {
    associatedtype T
    
    func create(type : T)
    func fetch() -> [T]?
    func update(type : T) -> Bool
    func delete(type : T) -> Bool
    func featchByIdentiifer(byIdentifier id : UUID) -> T?
}

struct EmployeeManager : CrudOperationForManager{
    typealias T = Employee
    
    private let _employeeDataRepository = EmployeeDataRepository()
    
    func create(type employee: Employee) {
        if !ValidatePassport(passport: employee.passport){
            employee.passport = nil
        }
        _employeeDataRepository.create(record: employee)
    }
    
    func fetch() -> [Employee]? {
        return _employeeDataRepository.getAll()
    }
    
    func update(type employee: Employee) -> Bool {
        if !ValidatePassport(passport: employee.passport){
            employee.passport = nil
        }
        
        return _employeeDataRepository.update(record: employee)
    }
    
    func delete(type employee: Employee) -> Bool {
        if ValidatePassport(passport: employee.passport){
            employee.passport = nil
        }
        return  _employeeDataRepository.delete(record: employee)
    }
    
    func featchByIdentiifer(byIdentifier id: UUID) -> Employee? {
       return _employeeDataRepository.get(fromId: id)
    }
   
    
    func ValidatePassport(passport : Passport?)->Bool{
        if passport == nil || passport?.passportId?.isEmpty == true || passport?.placeOfIssue?.isEmpty == true{
            return false
        }
        
        return true
    }
}
