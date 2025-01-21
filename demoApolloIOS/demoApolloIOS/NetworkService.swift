//
//  NetworkService.swift
//  demoApolloIOS
//
//  Created by Brinda Davda on 19/09/24.
//

import Foundation
import Apollo
import Foundation

final class NetworkService {
  static let shared = NetworkService()
//  private(set) var apollo = ApolloClient(url: URL(string: "https://spacex-production.up.railway.app")!)
    
    private(set) var apolloCountry = ApolloClient(url: URL(string: "https://countries.trevorblades.com/")!)
    private(set) var apollo = ApolloClient(url: URL(string: "https://spacex-production.up.railway.app")!) 
    
    private(set) lazy var apolloGithub: ApolloClient = {
       
        let url = URL(string: "https://api.github.com/graphql")!
        let configuration = URLSessionConfiguration.default
        
         let expire_token = "<Add_expier_token>"
         let current_token = "<Current_token>"
        
        let store = ApolloStore()
        configuration.httpAdditionalHeaders = ["authorization": "Bearer \(current_token)"]
        
        let sessionClient = URLSessionClient(sessionConfiguration: configuration, callbackQueue: nil)
//        let provider = LegacyInterceptorProvider(client: sessionClient, shouldInvalidateClientOnDeinit: true, store: store)
        let provider = DefaultInterceptorProvider(client: sessionClient, shouldInvalidateClientOnDeinit: true,store: store)
        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider, endpointURL: url)
        
        return ApolloClient(networkTransport: requestChainTransport, store: store)
        
    }()
    
  private init() { }
}
