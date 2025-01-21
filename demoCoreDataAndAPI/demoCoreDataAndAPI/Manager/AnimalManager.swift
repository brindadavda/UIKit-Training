//
//  AnimalManager.swift
//  demoCoreDataAndAPI
//
//  Created by apple on 16/02/24.
//

import Foundation

class AnimalManager {
    
    private let _cdAnimalDataRepository : AnimalRepository = AnimalDataRepository()
    private let _animalApiRepository: AnimalAPIRepository = AnimalAPIRepository()
    
    func getAnimalRecord(completionHandler:@escaping(_ result: Array<Animal>?)-> Void) {
        
        _cdAnimalDataRepository.getAllAnimalRecords{ response in
            if(response != nil && response?.count != 0){
                // return response to the view controller
                
                completionHandler(response)
            }else {
                // call the api
                self._animalApiRepository.getAllAnimalRecords (completionHandler: { apiResponse in
                    if(apiResponse != nil && apiResponse?.count != 0){
                        // insert record in core data
                        _ = self._cdAnimalDataRepository.batchInsertAnimalRecords(records: apiResponse!)
                        debugPrint("AnimalViewModel: Returning records to view controller")
                        completionHandler(apiResponse)
                    }
                })
            }
        }
    }

}
