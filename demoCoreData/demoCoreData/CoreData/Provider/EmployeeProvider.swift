//
//  EmployeeProvider.swift
//  demoCoreData
//
//  Created by apple on 16/02/24.
//

import Foundation
import CoreData

class EmployeeProvider{
    
    private weak var featchedResultControllerDelegate : NSFetchedResultsControllerDelegate?
    
    init(with featchedResultControllerDelegate: NSFetchedResultsControllerDelegate? = nil) {
        self.featchedResultControllerDelegate = featchedResultControllerDelegate
    }
    
    lazy var featchedResultContoller : NSFetchedResultsController<CDEmployee> = {
        let featchRequest : NSFetchRequest<CDEmployee> = CDEmployee.fetchRequest()
        featchRequest.fetchBatchSize = 5
        featchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        let controller = NSFetchedResultsController(fetchRequest: featchRequest, managedObjectContext: PersistentStorage.shared.context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = featchedResultControllerDelegate
        
        do{
            try controller.performFetch()
        }catch{
            debugPrint(error)
        }
        
        return controller
    }()
}
