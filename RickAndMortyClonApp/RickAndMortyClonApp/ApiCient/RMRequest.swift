//
//  RMRequest.swift
//  RickAndMortyClonApp
//
//  Created by apple on 29/06/24.
//

import Foundation

///Object that represent single API call
final class RMRequest{
    
    ///Base url
    ///Endpoint
    ///Path Component
    ///Query parameters

    private class Constants {
        static let baseURL =  "https://rickandmortyapi.com/api"
    }
    
    private let endPoint : RMEndPoint

    private let pathComponetns : [String]
    
    private let queryPerameters : [URLQueryItem]
    
    
    private var urlString : String{
        var string = Constants.baseURL
        string += "/\(endPoint.rawValue)"
        
        if !pathComponetns.isEmpty{
            string += "/"
            pathComponetns.forEach({
                string += "\($0)"
            })
        }
        
        if !queryPerameters.isEmpty{
            string += "/?"
            let argumentString = queryPerameters.compactMap({
                if let value = $0.value{
                    return "\($0.name)=\(value)"
                }
                return " "
            }).joined(separator: "&")
            string += argumentString
        }
        
        return string
    }
    
   public let httpMethod = "GET"
    
    //MARK: - Public
    
    public init(endPoint: RMEndPoint, pathComponetns: [String] = [] , queryPerameters: [URLQueryItem] = []) {
        self.endPoint = endPoint
        self.pathComponetns = pathComponetns
        self.queryPerameters = queryPerameters
    }
    
    public var url : URL?{
        return URL(string: urlString)
    }
}


extension RMRequest{
    static let listCharactersRequest = RMRequest(endPoint: .character)
}
