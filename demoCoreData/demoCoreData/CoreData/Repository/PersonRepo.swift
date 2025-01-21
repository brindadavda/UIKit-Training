//
//  PersonRepo.swift
//  demoCoreData
//
//  Created by apple on 15/02/24.
//

import Foundation

protocol PersonRepository : BaseRepository{
}

class PersonDataRepository : PersonRepository{
    
    typealias T = Person
    
    func create(record: Person) {
        let cdPerson = CDPerson(context: PersistentStorage.shared.context)
        cdPerson.id = record.id
        cdPerson.name = record.name
        
        if (record.vehicle != nil && record.vehicle?.count != 0){
            var vehicleSet = Set<CDVehicle>()
            
            record.vehicle?.forEach({ vehicle in
                let cdVehicle = CDVehicle(context: PersistentStorage.shared.context)
                cdVehicle.id = vehicle.id
                cdVehicle.brand = vehicle.name
                cdVehicle.type = vehicle.type

                vehicleSet.insert(cdVehicle)
            })
            
            cdPerson.toVehicle = vehicleSet
        }
        
        PersistentStorage.shared.saveContext()
    }
    
    func get(fromId id: UUID) -> Person? {
        let result = getDataFromID(byIdentifier: id, entity: "CDPerson") as? CDPerson
        guard result != nil else{return nil}
        return result?.convertToPerson()
    }
    
    func getAll() -> [Person]? {
        let result = PersistentStorage.shared.fetchManageObject(manageObject: CDPerson.self)
        var person = [Person]()
        
        result?.forEach({ cdPerson in
            person.append(cdPerson.convertToPerson())
        })
            
        return person
    }
    
    func update(record: Person) -> Bool {
        return false
    }
    
    func delete(record: Person) -> Bool {
        /*let result = getDataFromID(byIdentifier: record.id, entity: "CDPerson") as? CDPerson
        guard let data = result else{return false}
        
        PersistentStorage.shared.context.delete(data)
        PersistentStorage.shared.saveContext()*/
        
        return false
    }
    
    
}

