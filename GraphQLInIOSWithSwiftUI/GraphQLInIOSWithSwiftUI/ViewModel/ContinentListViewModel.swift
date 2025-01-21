//
//  ContinentListViewModel.swift
//  GraphQLInIOSWithSwiftUI
//
//  Created by Brinda Davda on 10/09/24.
//

import Foundation
import Apollo

class ContinentListViewModel: ObservableObject {
    
    @Published var continents: [ContinentViewModel] = []
    
    func populateAllContinents() {
        
        // Get all continents
        Network.shared.apollo.fetch(query: GetAllContinentsQuery()){ [weak self] result in
            print("result : \(result)")
            switch result{
            case .success(let graphQLResult):
                print("graphQLResult : \(graphQLResult)")
                if let containents = graphQLResult.data?.continents{
                    DispatchQueue.main.async{
                        self?.continents = containents.map(ContinentViewModel.init)
                    }
                }
            case .failure(let error):
                print(error)
            }
        
        }
    }
}



struct ContinentViewModel {
//    
    let continent: GetAllContinentsQuery.Data.Continent
    
    var code: String {
        continent.code
    }
    
    var name: String {
        continent.name
    }
   
}
