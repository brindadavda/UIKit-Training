//
//  Protocol.swift
//  demoCoreData
//
//  Created by apple on 14/02/24.
//

import Foundation

//crud operation repository
protocol BaseRepository{
    associatedtype T
    
    func create(record  : T)
    func get(fromId id : UUID) -> T?
    func getAll() -> [T]?
    func update(record : T) -> Bool
    func delete(record : T) -> Bool
}


