//
//  RMCharacters.swift
//  RickAndMortyClonApp
//
//  Created by apple on 29/06/24.
//

import Foundation

class RMCharacters : Codable{
    
    let id: Int
    let name: String
    let status: RMCharacterStatus
    let species: String
    let type: String
    let gender : RMCharacterGender
    let origin : RMOrigin
    let location: RMSingletonLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    init(id: Int, name: String, status: RMCharacterStatus, species: String, type: String, gender: RMCharacterGender, origin: RMOrigin, location: RMSingletonLocation, image: String, episode: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.status = status
        self.species = species
        self.type = type
        self.gender = gender
        self.origin = origin
        self.location = location
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
    
}



enum RMCharacterStatus : String , Codable{
    case alive = "Alive"
    case dead = "Dead"
    case `unknown` = "unknown"
}


enum RMCharacterGender : String , Codable{
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case `unknown` = "unknown"
}

