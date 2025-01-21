//
//  Apollo.swift
//  CountriesApp
//
//  Created by Mohammad Azam on 5/13/21.
//

import Foundation
import Apollo

class Network {
    
    static let shared = Network()
    lazy var apollo = ApolloClient(url: URL(string: "https://countries.trevorblades.com/")!)
    
    lazy var weather_apollo = ApolloClient(url: URL(string: "https://graphql-weather-api.herokuapp.com/")!)
    
    private init() { }
    
}
