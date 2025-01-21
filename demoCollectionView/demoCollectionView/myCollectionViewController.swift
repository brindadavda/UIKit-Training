//
//  myCollectionViewController.swift
//  demoCollectionView
//
//  Created by apple on 09/01/24.
//

import UIKit

private let reuseIdentifier = "cell"

class myCollectionViewController: UICollectionViewController {
    
    //creating array for shows the images
    @IBOutlet var myCollectionView: UICollectionView!
    
    
    let images : [String] = ["img1","img2","img3","img4","img1","img2","img3","img4"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
       // self.collectionView!.register(myUICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        
        let itemSize = (UIScreen.main.bounds.width/4 - 2)
        //giving layout
        let layout = UICollectionViewFlowLayout()
        //setting the layout size
        layout.itemSize = CGSize(width:  itemSize, height: itemSize)
        //setting
        layout.minimumInteritemSpacing  = 10
        layout.minimumLineSpacing = 10
      
        myCollectionView.collectionViewLayout = layout
       
        // Do any additional setup after loading the view.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return  1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! myUICollectionViewCell
        
        
        
        cell.myImageView.image = UIImage(named: images[indexPath.row]+".jpg")
        
    
        
        return cell
    }

   

}
