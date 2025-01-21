//
//  Enum.swift
//  RickAndMortyClonApp
//
//  Created by apple on 29/06/24.
//

import Foundation

enum StoryboardIdentifier : String{
    case rmTabVC = "RMTabVC"
    case rmCharacterVC = "RMCharacterVC"
    case rmEpisodeVC = "RMEpisodeVC"
    case rmLocationVC = "RMLocationVC"
    case rmSettingsVC = "RMSettingsVC"
}

enum NibName : String{
    case headerView = "HeaderView"
}


enum HeaderTitle : String{
    case charcter = "Characters"
    case episods = "Episods"
    case location = "Locations"
    case settings = "Settings"
}

enum CellIdentifier : String{
case charcaterCell = "Cell"
}
