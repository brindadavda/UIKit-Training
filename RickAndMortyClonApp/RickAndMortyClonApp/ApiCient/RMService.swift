//
//  RMService.swift
//  RickAndMortyClonApp
//
//  Created by apple on 29/06/24.
//

import Foundation

///API Service
final class RMService {
    
    ///shared singleton application
    static let shared = RMService()
    
    ///Privilized Constructore
    private init () {}
    
    
    ///Send Api Call
    ///- Perameter :
    ///     - request : Request Initializer
    ///     - type : typeof object we expect to get back
    ///     - completion :  Callback with data or error
    public func execute<T>(_ request: RMRequest,
                             expecting type: T.Type,
                             completion: @escaping (Result<T, Error>) -> Void) where T: Decodable {
          guard let urlRequest = self.request(from: request) else {
              completion(.failure(RMServiceError.failedToCreateRequest))
              return
          }
          
          let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
              guard let data = data, error == nil else {
                  completion(.failure(RMServiceError.failedToGetData))
                  return
              }
              
              do {
                  let result = try JSONDecoder().decode(type, from: data)
                  completion(.success(result))
              } catch {
                  completion(.failure(error))
              }
          }
          
          task.resume()
      }
    
    //MARK: - Private
    private func request(from rmRequest : RMRequest) -> URLRequest?{
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        return request
    }
    
    
    enum RMServiceError : Error{
        case failedToCreateRequest
        case failedToGetData
    }
    
}



