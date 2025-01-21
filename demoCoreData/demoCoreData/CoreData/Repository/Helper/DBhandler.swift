//
//  DBhandler.swift
//  demoCoreData
//
//  Created by apple on 15/02/24.
//

import Foundation
import CoreData

func getDataFromID(byIdentifier id : UUID , entity : String) -> NSManagedObject?{
   let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
   let predicate = NSPredicate(format: "id==%@", id as CVarArg)

   
   fetchRequest.predicate = predicate
   do{
      let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
       
       guard result != nil else{return nil}
       
       return result
       
   }catch let error{
       debugPrint(error)
   }
   
   return nil
}
