//
//  CharecterListViewCellViewModel.swift
//  RickAndMortyClonApp
//
//  Created by apple on 29/06/24.
//

import Foundation

class RMCharecterListViewCellViewModel{
    public let charecterName : String
    private let characterStatus : RMCharacterStatus
    public let charcaterImageUrl : URL?
    
    
    init(charecterName: String, characterStatus: RMCharacterStatus, charcaterImageUrl: URL?) {
        self.charecterName = charecterName
        self.characterStatus = characterStatus
        self.charcaterImageUrl = charcaterImageUrl
    }

    public var chacterStatusText : String{
        return characterStatus.rawValue
    }
  
    
    public func fetchImage(completion : @escaping (Result<Data,Error>) -> Void){
        guard let url = charcaterImageUrl else {
            completion(.failure(URLError(.badURL)))         
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data , _ , error in
            guard let data = data , error == nil else{
                completion(.failure(error ?? URLError(.badServerResponse)))
                return 
            }
            
            completion(.success(data))
             
        }
        
        task.resume()
    }
    
    
}
