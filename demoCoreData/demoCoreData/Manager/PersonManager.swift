//
//  PersonManager.swift
//  demoCoreData
//
//  Created by apple on 15/02/24.
//

import Foundation
struct PersonManager : CrudOperationForManager{
    typealias T = Person
    
    private let _personDataRepository = PersonDataRepository()
    
    func create(type: Person) {
        return _personDataRepository.create(record: type)
    }
    
    func fetch() -> [Person]? {
        return _personDataRepository.getAll()
    }
    
    func update(type: Person) -> Bool {
        return _personDataRepository.update(record: type)
    }
    
    func delete(type: Person) -> Bool {
        return _personDataRepository.delete(record: type)
    }
    
    func featchByIdentiifer(byIdentifier id: UUID) -> Person? {
        return _personDataRepository.get(fromId: id)
    }
    
}
