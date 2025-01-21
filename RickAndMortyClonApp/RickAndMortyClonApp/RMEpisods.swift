//
//  RMEpisods.swift
//  RickAndMortyClonApp
//
//  Created by apple on 29/06/24.
//

import Foundation

class RMEpisods : Codable {
         let id: Int
         let name: String
         let air_date: String
         let episode: String
         let characters: [String]
         let url: String
         let created: String
    
    init(id: Int, name: String, air_date: String, episode: String, characters: [String], url: String, created: String) {
        self.id = id
        self.name = name
        self.air_date = air_date
        self.episode = episode
        self.characters = characters
        self.url = url
        self.created = created
    }
}
