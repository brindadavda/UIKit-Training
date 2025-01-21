//
//  RMCharecterCVCell.swift
//  RickAndMortyClonApp
//
//  Created by apple on 29/06/24.
//

import UIKit

class RMCharecterCVCell: UICollectionViewCell {
    
    @IBOutlet weak var ivCharecterImg : UIImageView!
    @IBOutlet weak var lblCharacterName : UILabel!
    @IBOutlet weak var lblCharecterStatus : UILabel!
    
    
    
    public func configure(with viewModel : RMCharecterListViewCellViewModel){
        
      
        lblCharacterName.text = viewModel.charecterName
        lblCharecterStatus.text = viewModel.chacterStatusText
     
        viewModel.fetchImage(completion: { result in
            switch result{
            case .success(let data) :
                DispatchQueue.main.async{
                    self.ivCharecterImg.image = UIImage(data: data)
                }
            case .failure(let error) :
                print(String(describing: error))
                
              
            }
        })
    }
}
