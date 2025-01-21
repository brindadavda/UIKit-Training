//
//  RMGetAllCharacterResponse.swift
//  RickAndMortyClonApp
//
//  Created by apple on 29/06/24.
//

import Foundation

class RMGetAllCharacterResponse : Codable{
    class Info : Codable{
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMCharacters]
}
