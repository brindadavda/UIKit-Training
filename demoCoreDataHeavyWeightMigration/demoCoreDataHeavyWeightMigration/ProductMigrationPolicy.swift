//
//  ProductMigrationPolicy.swift
//  demoCoreDataHeavyWeightMigration
//
//  Created by apple on 16/02/24.
//

import Foundation
import CoreData

class ProductMigrationPolicy : NSEntityMigrationPolicy{
    
    override func createDestinationInstances(forSource sInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
          
          if(sInstance.entity.name == ProductEntityConstant.entityName) {
              
              let id = sInstance.value(forKey: ProductEntityConstant.id) as? UUID
              let name = sInstance.value(forKey: ProductEntityConstant.name) as? String
              let manufactureDate = sInstance.value(forKey: ProductEntityConstant.manufactureDate) as? String
              let expiryDate = sInstance.value(forKey: ProductEntityConstant.expiryDate) as? String
              let price = sInstance.value(forKey: ProductEntityConstant.price) as? String
              
              let newProductEntity = NSEntityDescription.insertNewObject(forEntityName: "CDProduct", into: manager.destinationContext)
              
              newProductEntity.setValue(id, forKey: ProductEntityConstant.id)
              newProductEntity.setValue(name, forKey: ProductEntityConstant.name)
              newProductEntity.setValue(manufactureDate?.toDate(), forKey: ProductEntityConstant.manufactureDate)
              newProductEntity.setValue(expiryDate?.toDate(), forKey: ProductEntityConstant.expiryDate)
              newProductEntity.setValue(price?.toDecimal(), forKey: ProductEntityConstant.price)
          }
      }
    
}
