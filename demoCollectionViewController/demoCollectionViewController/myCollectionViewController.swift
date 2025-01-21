//
//  myCollectionViewController.swift
//  demoCollectionViewController
//
//  Created by apple on 09/01/24.
//

import UIKit

private let reuseIdentifier = "cell"

class myCollectionViewController: UICollectionViewController {
    
    let images : [String] = ["img1","img1","img1","img1","img1","img1","img1","img1"]
    
    @IBOutlet var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
    //self.collectionView!.register(myUICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        

        // Do any additional setup after loading the view.
        let itemSize = (UIScreen.main.bounds.width/4 - 2)
        //giving layout
        let layout = UICollectionViewFlowLayout()
        //setting the layout size
        layout.itemSize = CGSize(width:  itemSize, height: itemSize)
        //setting
        layout.minimumInteritemSpacing  = 10
        layout.minimumLineSpacing = 10
      
        myCollectionView.collectionViewLayout = layout
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return images.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! myUICollectionViewCell
    
        // Configure the cell
        
        cell.imageView.image = UIImage(named: images[indexPath.row] + ".jpg")
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
