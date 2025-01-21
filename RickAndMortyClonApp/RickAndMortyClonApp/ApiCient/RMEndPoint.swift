//
//  RMEndPoint.swift
//  RickAndMortyClonApp
//
//  Created by apple on 29/06/24.
//

import Foundation


///Unique API endpoint
@frozen enum RMEndPoint : String{
    ///Endpoint to get character info
    case character = "character"
    ///Endpoint to get episod info
    case episods = "episods"
    ///Endpoint to get location info
    case location = "location"
}
