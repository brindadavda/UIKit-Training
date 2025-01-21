//
//  Network.swift
//  GraphQLWithSPMINIOS
//
//  Created by Brinda Davda on 13/09/24.
//

import Foundation
import Foundation
import Apollo

class Network {
  static let shared = Network()

  private init() {}

  private(set) lazy var apollo = ApolloClient(url: URL(string: "https://api.chargetrip.io/graphql")!)
}
