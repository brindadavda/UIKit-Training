//
//  Apollo.swift
//  GraphQLInIOSWithSwiftUI
//
//  Created by Brinda Davda on 10/09/24.
//

import Foundation
import Apollo

class Network {
    
    static let shared = Network()
    lazy var apollo = ApolloClient(url: URL(string: "https://countries.trevorblades.com/")!)
    
    private init() {
    }
}
