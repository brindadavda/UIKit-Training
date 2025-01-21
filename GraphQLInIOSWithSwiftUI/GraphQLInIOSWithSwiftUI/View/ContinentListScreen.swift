//
//  ContinentListScreen.swift
//  GraphQLInIOSWithSwiftUI
//
//  Created by Brinda Davda on 10/09/24.
//

import SwiftUI

struct ContinentListScreen: View {
    @StateObject private var continentListVM = ContinentListViewModel()
        
        var body: some View {
            NavigationView {
                List(continentListVM.continents, id: \.code) { continent in

                    NavigationLink(
                        destination: CountryListScreen(continent: continent),
                        label: {
                            Text(continent.name)
                        })

                }
                .onAppear(perform: {
                    continentListVM.populateAllContinents()
                })
                .navigationTitle("Continents")
            }
        }
}

#Preview {
    ContinentListScreen()
}
