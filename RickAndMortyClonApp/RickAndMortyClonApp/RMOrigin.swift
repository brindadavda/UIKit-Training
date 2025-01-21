//
//  RMOrigin.swift
//  RickAndMortyClonApp
//
//  Created by apple on 29/06/24.
//

import Foundation

class RMOrigin : Codable {
    let name : String 
    let url : String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
