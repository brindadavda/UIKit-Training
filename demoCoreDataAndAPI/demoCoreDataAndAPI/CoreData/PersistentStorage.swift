//
//  PersistentStorage.swift
//  demoCoreDataAndAPI
//
//  Created by apple on 16/02/24.
//

import Foundation
import CoreData

class PersistentStorage{
    
    static let shared = PersistentStorage()
    private init(){}
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "demoCoreDataAndAPI")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    lazy var context = persistentContainer.viewContext
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Fetch NSManageObject
    
    func fetchManageObject<T: NSManagedObject>(manageObject : T.Type) -> [T]?
    {
        do{
            guard let result = try PersistentStorage.shared.context.fetch(T.fetchRequest()) as? [T] else{
                return nil
            }
            return result
        }catch let error{
            debugPrint("Error : \(error)")
        }
        return nil
    }
    
    // MARK: - Print Document Dictionary Path
    
    func printDocumentDirectoryPath() {
           debugPrint(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0])
        }
}
