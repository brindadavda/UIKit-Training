//
//  StoryViewCollectionCell.swift
//  instagramClone
//
//  Created by apple on 12/01/24.
//

import UIKit

class StoryViewCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var IvView: UIView!
    
    @IBOutlet weak var label: UILabel!
    
    //global variable
    let reuseIdentifierforStory = "StoryCell"
    let images =  HomeViewController.images
    
    //function on
    @objc func handleProfileImageTapped(){
        print("\(#function) : Story Profile Image Taped")
    }
    
    
    func setStoryCVC(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath ) -> UICollectionViewCell{
        //story collection view
        let storycollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierforStory, for: indexPath) as! StoryViewCollectionCell
        
        storycollectionViewCell.imageView?.image = UIImage(named:  images[indexPath.row]+".png")
        
        storycollectionViewCell.label.text = images[indexPath.row]
        
        return storycollectionViewCell
        
    }
    
    
    
}
