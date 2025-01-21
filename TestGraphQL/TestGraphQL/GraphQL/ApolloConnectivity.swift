//
//  ApolloConnectivity.swift
//  TestGraphQL
//
//  Created by Brinda Davda on 12/09/24.
//

import Foundation
import Apollo

class Network {
    
    static let shared = Network()
    lazy var apollo = ApolloClient(url: URL(string: "https://countries.trevorblades.com/")!)
    
    private let apolloFruits : ApolloClient = {
            let endpointURL = URL(string: "https://fruits-api.netlify.app/graphql")!
            let store = ApolloStore()
            let interceptorProvider = NetworkInterceptorsProvider(
                interceptors: [TokenInterceptor(token: "your_token_here")],
                store: store
            )
            let networkTransport = RequestChainNetworkTransport(
                interceptorProvider: interceptorProvider, endpointURL: endpointURL
            )
            return ApolloClient(networkTransport: networkTransport, store: store)
        }()
    
    let endpointURL = URL(string: "https://graphqlzero.almansi.me/api")!
    
    lazy var apolloUser = ApolloClient(url: endpointURL)
    
    private init() {
    }
}
