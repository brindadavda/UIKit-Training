//
//  CharacterListViewViewModel.swift
//  RickAndMortyClonApp
//
//  Created by apple on 29/06/24.
//

import Foundation
import UIKit

class RMCharacterListViewViewModel : NSObject  {
    
    func featchChatecters(){
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharacterResponse.self){ result in
            switch result{
            case .success(let model):
                print("image : " + String(model.results.first?.image ?? "No image"))
                
            case .failure(let error):
                print(String(describing: error))
            }
            
        }
    }
}

extension RMCharacterListViewViewModel :  UICollectionViewDelegate,  UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.charcaterCell.rawValue, for: indexPath) as? RMCharecterCVCell else { return UICollectionViewCell() }
        
        let viewModel = RMCharecterListViewCellViewModel(charecterName: "Afraz", characterStatus: .alive, charcaterImageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
        
        
        cell.backgroundColor = .black
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView , layout collectionViewlayout : UICollectionViewLayout , sizeForItemAt indexpath : IndexPath) -> CGSize{
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 40)/2
        return CGSize(width: width, height: width * 1.5)
    }
    
   
    
}
