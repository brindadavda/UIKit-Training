//
//  EnimalAPIRepository.swift
//  demoCoreDataAndAPI
//
//  Created by apple on 16/02/24.
//

import Foundation

class AnimalAPIRepository : AnimalBaseRepository{
    
    func getAllAnimalRecords(completionHandler: @escaping (Array<Animal>?) -> Void) {
        let task = URLSession.shared.dataTask(with: ApiResource.animalResourceRequestURL!){(data , response , error) in
            if let data = data {
                do{
                    let result = try JSONDecoder().decode(AnimalResponse.self, from: data)
                    completionHandler(result.animals)
                }catch{
                    debugPrint(error)
                }
            }
        }
        task.resume()
    }
}
