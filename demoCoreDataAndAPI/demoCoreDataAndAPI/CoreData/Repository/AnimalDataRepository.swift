//
//  EnimalDataRepository.swift
//  demoCoreDataAndAPI
//
//  Created by apple on 16/02/24.
//

import Foundation
import CoreData

protocol AnimalRepository : AnimalBaseRepository{
    func insertAnimalRecords(record : Array<Animal>) -> Bool
    func batchInsertAnimalRecords(records : Array<Animal>) -> Bool
}

class AnimalDataRepository : AnimalRepository{
    
    //batch request usefull for above ios 13 and also no relationship
    func batchInsertAnimalRecords(records : Array<Animal>) -> Bool{
        PersistentStorage.shared.persistentContainer.performBackgroundTask({
            privateManagedContext in
            //batch insert
            let request = self.createBatchInsertRequest(records: records)
            do{
                try privateManagedContext.execute(request)
            }catch{
                debugPrint(error)
            }
        })
        
        return true
    }
    
    private func createBatchInsertRequest(records : Array<Animal>) -> NSBatchInsertRequest{
        
        let totalCount = records.count
        var index = 0
        
        let batchInsert = NSBatchInsertRequest(entity: CDAnimal.entity(), managedObjectHandler: {
            (manageObject : NSManagedObject) -> Bool in
            
            guard index < totalCount  else {return true}
            
            if let animal = manageObject as? CDAnimal{
                let data = records[index]
                
                animal.id = UUID()
                animal.name = data.name
                animal.image = data.image
            }
            
            index += 1
            return false
        })
        
        return batchInsert
    }
    
    //traditional insert
    func insertAnimalRecords(record records: Array<Animal>) -> Bool {
        PersistentStorage.shared.persistentContainer.performBackgroundTask { privateManagedContext in
            //insert code
            records.forEach { animalRecord in
                let cdAnimal = CDAnimal(context: privateManagedContext)
                cdAnimal.id = UUID()
                cdAnimal.name = animalRecord.name
                cdAnimal.image = animalRecord.image
            }

            if(privateManagedContext.hasChanges){
                try? privateManagedContext.save()
                debugPrint("AnimalDataRepository: Insert record operation is completed")
            }
        }

        return true
    }
    
    
    func getAllAnimalRecords(completionHandler: @escaping (Array<Animal>?) -> Void) {
        
        PersistentStorage.shared.printDocumentDirectoryPath()
        
        let animaldata = PersistentStorage.shared.fetchManageObject(manageObject: CDAnimal.self)
        
        var animals = [Animal]()
        
        animaldata?.forEach({ cdAnimal in
            let animal = Animal(name: cdAnimal.name!, image: cdAnimal.image!)
            animals.append(animal)
            
        })
        
        completionHandler(animals)
    }
}
