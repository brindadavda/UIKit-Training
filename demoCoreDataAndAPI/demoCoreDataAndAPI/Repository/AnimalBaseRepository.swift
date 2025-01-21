//
//  AnimalRepository.swift
//  demoCoreDataAndAPI
//
//  Created by apple on 16/02/24.
//

import Foundation


protocol AnimalBaseRepository{
    func getAllAnimalRecords(completionHandler : @escaping(_ result : Array<Animal>?)  -> Void)
}
