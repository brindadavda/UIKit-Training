//
//  PostViewCollectionCell.swift
//  instagramClone
//
//  Created by apple on 12/01/24.
//

import UIKit

// 1
protocol myProtocol {
    func loadNewScreen(activityViewController : UIViewController) -> Void;
}


class PostViewCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var userIV: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var moreBtn: UIButton!
    
    @IBOutlet weak var favouriteBtn: UIButton!
    
    @IBOutlet weak var messageBtn: UIButton!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    @IBOutlet weak var bookmarkBtn: UIButton!
    
    @IBOutlet weak var postDetailsLabel: UILabel!
    
    @IBOutlet weak var postIV: UIImageView!
    
    //global variable
    let reuseIdentifierforPost = "PostCell"
    let images : [String] =  HomeViewController.images

    static var likedImages : [Int] = Array(repeating: 0, count: HomeViewController.images.count);
    
    var index : Int?
    
    
    //my protocol delegate variable
    var delegate: myProtocol!

    func setPostCVC(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        //post collection view
        let postCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifierforPost, for: indexPath) as! PostViewCollectionCell
        
        postCollectionViewCell.userIV?.image = UIImage(named:  images[indexPath.row]+".png")
        
        postCollectionViewCell.userNameLabel.text = images[indexPath.row]
        
        return postCollectionViewCell
    }
    
    
    //function on
    @objc func handleUserImageTapped(_ sender: UITapGestureRecognizer){
        //get the tage
            self.userIV?.isUserInteractionEnabled = true
            print("\(#function) : Post User Image Taped")
        }
        
    
                                                        
    //function on postImage tapped
    @objc func handlePostImageTapped(_ sender : UITapGestureRecognizer){
            self.postIV?.isUserInteractionEnabled = true
            print("\(#function) : Post's Image Taped")
        }
            
    @IBAction func actionMoreBtnClicked(_ sender: UIButton){
        //do the task you want to perform
        print("Postview Collection cell : btn clicked on more")
    }
    
    
    @IBAction func actionBookMark(_ sender: UIButton) {
        //do the task of book mark over here
        print("Postview Collection cell : btn clicked on bookmark")
        if(bookmarkBtn.isSelected == true){
            bookmarkBtn.setImage(UIImage(systemName: "bookmark"), for: .normal)
            bookmarkBtn.isSelected = false
            postDetailsLabel.text?.replace("Bookmarked by me", with: "  ")
        }else{
            bookmarkBtn.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            bookmarkBtn.isSelected = true
            postDetailsLabel.text! +=  "Bookmarked by me "
        }
    }
    
    @IBAction func actionShare(_ sender: UIButton) {
        //do the shre logic over here
        print("Postview Collection cell : btn clicked on share")
        
        let img :String = images[HomeViewController.index ?? 0]
        
        // image to share
        let image = UIImage(named: img)
        
        // set up activity view controller
        let imageToShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = contentView // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook , UIActivity.ActivityType.assignToContact]
        
        // present the view controller
        delegate.loadNewScreen(activityViewController: activityViewController)
        
              
    }
    
    @IBAction func actionMessage(_ sender: UIButton) {
        //do the message logic over here
        print("Postview Collection cell : btn clicked on message")
    }

    @IBAction func actionLike(_ sender: UIButton) {
        //do the like logic over here
        if(favouriteBtn.isSelected == true){
            favouriteBtn.setImage(UIImage(systemName: "heart"), for: .normal)
            favouriteBtn.isSelected = false
            if let i = HomeViewController.index{
                PostViewCollectionCell.likedImages.removeSubrange(i...i)
            }
            postDetailsLabel.text?.replace("Liked by others", with: "  ")
        }else{
            favouriteBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            favouriteBtn.isSelected = true
            if let i = HomeViewController.index{
                PostViewCollectionCell.likedImages.insert(1, at: i)
               
            }
            postDetailsLabel.text! += " Liked by others "

        }
        
        
    }
    
}
