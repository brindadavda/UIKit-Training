//
//  CountryListViewModel.swift
//  GraphQLInIOSWithSwiftUI
//
//  Created by Brinda Davda on 10/09/24.
//

import Foundation
import Apollo


class CountryListViewModel: ObservableObject {
    
    @Published var countries: [CountryViewModel] = []
    
    func populateCountriesByContinent(code: String) {
        
        // Get all countries based on a continent
        Network.shared.apollo.fetch(query: GetCountriesByContinentQuery(code: code)){ [weak self] result in
            print("result : \(result)")
            switch result{
            case .success(let graphQLResult):
                print("graphQLResult : \(graphQLResult)")
                if let containents = graphQLResult.data?.countries{
                    DispatchQueue.main.async{
                        self?.countries = containents.map(CountryViewModel.init)
                    }
                }
            case .failure(let error):
                print(error)
            }
        
        }
    }
    
}


struct CountryViewModel {
    
    let country: GetCountriesByContinentQuery.Data.Country
    
    var code: String {
        country.code
    }
    
    var name: String {
        country.name
    }
    
    var emoji: String {
        country.emoji
    }
    
    var states: [StateViewModel] {
         country.states.map(StateViewModel.init)
    }
}

struct StateViewModel {
    
    let state: GetCountriesByContinentQuery.Data.Country.State
    
    var name: String {
        state.name
    }
    
}
