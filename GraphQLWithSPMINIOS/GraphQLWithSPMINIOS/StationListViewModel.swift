//
//  StationListViewModel.swift
//  GraphQLWithSPMINIOS
//
//  Created by Brinda Davda on 13/09/24.
//

import Foundation
import Apollo
import ChargeTripAPI


final class StationListViewModel {
    init() {
        Network.shared.apollo.fetch(query: StationListQuery()) { result in
            switch result {
            case .success(let graphQLResult):
                print("Success! Result data's: \(graphQLResult.data)")
            case .failure(let error):
                print("Failure! Error: \(error)")
            }
        }
    }
}
